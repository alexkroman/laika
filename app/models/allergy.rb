class Allergy < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :adverse_event_type
  belongs_to :severity_term
  belongs_to :allergy_status_code
  belongs_to :allergy_type_code
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  #Reimplementing from MatchHelper
  def section_name
    "Allergies Module"
  end

  def validate_c32(document)
    errors = []
    begin
      section = REXML::XPath.first(document,"//cda:section[cda:templateId[@root = '2.16.840.1.113883.10.20.1.2']]", @@default_namespaces)
      
      # To find the allergy we are looking for, we know that the product free text name will always be there
      # below is the monster XPath expression to find it
      xpath = <<XPATH
      cda:entry/
      cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']/ 
      cda:entryRelationship[@typeCode='SUBJ']/ 
      cda:observation[cda:templateId[@root='2.16.840.1.113883.10.20.1.18'] and cda:participant[@typeCode='CSM']/
      cda:participantRole[@classCode='MANU']/
      cda:playingEntity[@classCode='MMAT']/
      cda:name/text() = $free_text_product]
XPATH
    
      #strip out all of the whitespace at the beginning and end of the expression
      xpath.gsub!(/^\s*/, '')
      xpath.gsub!(/\s*$/, '')
      xpath.gsub!(/\n/, '')
      adverse_event = REXML::XPath.first(section, xpath, @@default_namespaces, {"free_text_product" => self.free_text_product})
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
        # if self.severity_term
        #       
        #  severity_element = REXML::XPath.first(adverse_event, "cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.55']",
        #                                        @@default_namespaces)
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
    section = REXML::XPath.first(clinical_document, "//cda:section[cda:templateId[@root = '2.16.840.1.113883.10.20.1.2']]", @@default_namespaces)
    if section
      obs_xpath = "cda:entry/cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']/cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId[@root='2.16.840.1.113883.10.20.1.18']]"
      observation = REXML::XPath.first(section, obs_xpath, @@default_namespaces)
      if observation
        obs_value = REXML::XPath.first(observation, "cda:value", @@default_namespaces)
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
  
  def to_c32(xml)
    
    xml.entry do
      xml.act("classCode" => "ACT", "moodCode" => "EVN") do
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.27")
        xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.6")
        xml.id("root" => "2C748172-7CC2-4902-8AF0-23A105C4401B")
        xml.code("nullFlavor"=>"NA")
        xml.entryRelationship("typeCode" => "SUBJ") do
          xml.observation("classCode" => "OBS", "moodCode" => "EVN") do
            xml.templateId("root" => "2.16.840.1.113883.10.20.1.18")
            if allergy_type_code
              xml.value("code" => allergy_type_code.code, "displayName" => allergy_type_code.name)
            end 
            if adverse_event_type 
              xml.code("code" => adverse_event_type.code, 
                       "displayName" => adverse_event_type.name, 
                       "codeSystem" => "2.16.840.1.113883.6.96", 
                       "codeSystemName" => "SNOMED CT")
            else
              xml.code("nullFlavor"=>"N/A")
            end
            xml.statusCode("code"=>"completed")
            if start_event != nil || end_event != nil
              xml.effectiveTime do
                if start_event != nil 
                  xml.low("value" => start_event.strftime("%Y%m%d"))
                end
                if end_event != nil
                  xml.high("value" => end_event.strftime("%Y%m%d"))
                else
                  xml.high("nullFlavor" => "UNK")
                end
              end
            end
            xml.participant("typeCode" => "CSM") do
              xml.participantRole("classCode" => "MANU") do
                xml.playingEntity("classCode" => "MMAT") do
                  xml.code("code" => product_code, 
                           "displayName" => free_text_product, 
                           "codeSystem" => "2.16.840.1.113883.6.88", 
                           "codeSystemName" => "RxNorm")
                  xml.name free_text_product
                end
              end
            end
            #if allergy_status_code
            #  xml.entryRelationship("typeCode" => "REFR") do
            #    xml.observation("classCode" => "OBS", "moodCode" => "EVN") do
            #      xml.templateId("root" => "2.16.840.1.113883.10.20.1.39")
            #     xml.code("code" => "33999-4", 
            #               "displayName" => "Status",
            #               "codeSystem" => "2.16.840.1.113883.6.1", 
            #               "codeSystemName" => "AlertStatusCode")
            #      xml.statusCode("code" => "completed")
            #      xml.value("xsi:type" => "CE", 
            #                "code" => allergy_status_code.code,
            #                "displayName" => allergy_status_code.name,
            #                "codeSystem" => "2.16.840.1.113883.6.96", 
            #                "codeSystemName" => "SNOMED CT") 
            #    end
            #  end
            #end
          end
        end
        
        #if severity_term
        #  xml.entryRelationship("typeCode" => "SUBJ", "inversionInd" => "true") do
        #    xml.observation("classCode" => "OBS", "moodCode" => "EVN") do
        #      xml.templateId("root" => "2.16.840.1.113883.10.20.1.55")
        #      xml.code("code" => "SEV", 
        #               "displayName" => "Severity",
        #               "codeSystem" => "2.16.840.1.113883.5.4", 
        #               "codeSystemName" => "ActCode")
        #     xml.text do
        #        xml.reference("value" => "#severity-" + id.to_s)
        #     end
        #     xml.statusCode("code" => "completed")
        #      xml.value("xsi:type" => "CD", 
        #                "code" => severity_term.code,
        #               "displayName" => severity_term.name,
        #                "codeSystem" => "2.16.840.1.113883.6.96", 
        #                "codeSystemName" => "SNOMED CT")
        #    end
        #  end
        #end
        
      end
    end
  end
  
  def randomize(birth_date)
    @possible_allergin = ["Asprin 1191", "Codeine 2670", "Penicillin 70618"]
    @allergin = @possible_allergin[rand(3)]
    self.free_text_product = @allergin.split[0]
    self.product_code = @allergin.split[1]
    
    self.start_event = DateTime.new(birth_date.year + rand(DateTime.now.year - birth_date.year), rand(12) + 1, rand(28) +1)
    
    self.adverse_event_type = AdverseEventType.find(:all).sort_by {rand}.first
    self.severity_term = SeverityTerm.find(:all).sort_by {rand}.first
    self.allergy_type_code = AllergyTypeCode.find(:all).sort_by {rand}.first
    self.allergy_status_code = AllergyStatusCode.find(:all).sort_by {rand}.first
  end
  
end
