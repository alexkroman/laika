  
  module AllergyC32Validation


    include MatchHelper
    #Reimplementing from MatchHelper
    def section_name
      "Allergies Module"
    end

    def validate_c32(document)
      errors = []
      begin
        section = REXML::XPath.first(document,"//cda:section[cda:templateId[@root = '2.16.840.1.113883.10.20.1.2']]", MatchHelper::DEFAULT_NAMESPACES)
        
        # To find the allergy we are looking for, we know that the product free text name will always be there
        # below is the monster XPath expression to find it
        xpath = %{
        cda:entry/
        cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']/ 
        cda:entryRelationship[@typeCode='SUBJ']/ 
        cda:observation[cda:templateId[@root='2.16.840.1.113883.10.20.1.18'] and cda:participant[@typeCode='CSM']/
        cda:participantRole[@classCode='MANU']/
        cda:playingEntity[@classCode='MMAT']/
        cda:name/text() = $free_text_product]
         }

        #strip out all of the whitespace at the beginning and end of the expression
        xpath.gsub!(/^\s*/, '')
        xpath.gsub!(/\s*$/, '')
        xpath.gsub!(/\n/, '')
        adverse_event = REXML::XPath.first(section, xpath, MatchHelper::DEFAULT_NAMESPACES, {"free_text_product" => self.free_text_product})
        if adverse_event
          errors << match_value(adverse_event, 
                               "cda:effectiveTime/cda:low/@value", 
                               'start_event', 
                               self.start_event.andand.to_formatted_s(:hl7_ts))
          errors << match_value(adverse_event, 
                               "cda:effectiveTime/cda:high/@value", 
                               'end_event', 
                               self.end_event.andand.to_formatted_s(:hl7_ts))
          errors << match_value(adverse_event, 
                                "cda:participant[@typeCode='CSM']/cda:participantRole[@classCode='MANU']/cda:playingEntity[@classCode='MMAT']/cda:name", 
                                'free_text_product', 
                                self.free_text_product)
          errors << match_value(adverse_event, 
                                "cda:participant[@typeCode='CSM']/cda:participantRole[@classCode='MANU']/cda:playingEntity[@classCode='MMAT']/cda:code[@codeSystem='2.16.840.1.113883.6.88']/@code", 
                                'product_code', 
                                self.product_code)
          # if self.severity_term
          #  severity_element = REXML::XPath.first(adverse_event, "cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.55']",
          #                                        MatchHelper::DEFAULT_NAMESPACES)
          #  if severity_element
          #   errors.concat(self.severity_term.validate_c32(severity_element))
          #  else
          #    errors << ContentError.new(:section => 'allergies', :subsection => 'severity_term', :error_message => "Unable to find severity", :location => adverse_event.andand.xpath)
          #  end
          #end
        else
          errors << ContentError.new(:section => 'allergies', 
                                     :error_message => "Unable to find product #{free_text_product}", 
                                     :location => section.andand.xpath)
        end
      rescue
        errors << ContentError.new(:section => 'Allergy', 
                                   :error_message => 'Invalid, non-parsable XML for allergy data',
                                   :type=>'error',
                                   :location => document.xpath)
      end
      errors.compact
    end

    # Will get called by patient data if the boolean is set there
    def check_no_known_allergies_c32(clinical_document)
      errors = []
      section = REXML::XPath.first(clinical_document, "//cda:section[cda:templateId[@root = '2.16.840.1.113883.10.20.1.2']]", MatchHelper::DEFAULT_NAMESPACES)
      if section
        obs_xpath = "cda:entry/cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']/cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId[@root='2.16.840.1.113883.10.20.1.18']]"
        observation = REXML::XPath.first(section, obs_xpath, MatchHelper::DEFAULT_NAMESPACES)
        if observation
          obs_value = REXML::XPath.first(observation, "cda:value", MatchHelper::DEFAULT_NAMESPACES)
          if obs_value
            errors << match_value(obs_value, "@displayName", 'no_known_allergies', 'No known allergies')
            errors << match_value(obs_value, "@code", 'no_known_allergies', '160244002')
            errors << match_value(obs_value, "@codeSystemName", 'no_known_allergies', 'SNOMED CT')
            errors << match_value(obs_value, "@codeSystem", 'no_known_allergies', '2.16.840.1.113883.6.96')
          else
            errors << ContentError.new(:section => 'allergies', :error_message => "Unable to find observation value", :location => observation.xpath)
          end
        else
          errors << ContentError.new(:section => 'allergies', :error_message => "Unable to find observation", :location => section.xpath)
        end
      else
        errors << ContentError.new(:section => 'allergies', :error_message => "Unable to find allergies section", :location => clinical_document.andand.xpath)
      end
      errors.compact
    end

  end