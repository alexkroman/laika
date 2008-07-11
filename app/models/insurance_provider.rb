class InsuranceProvider < ActiveRecord::Base
  
  strip_attributes!

  belongs_to :patient_data
  belongs_to :insurance_type
  belongs_to :coverage_role_type
  belongs_to :role_class_relationship_formal_type

  has_one    :insurance_provider_patient
  has_one    :insurance_provider_subscriber
  has_one    :insurance_provider_guarantor
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def validate_c32(document)
    errors = []
    
    begin
      section = REXML::XPath.first(document,"//cda:section[cda:templateId/@root='2.16.840.1.113883.10.20.1.9']",@@default_namespaces)
      parentAct = REXML::XPath.first(section,"cda:entry/cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.20']",@@default_namespaces)
      childAct = REXML::XPath.first(parentAct,"cda:entryRelationship/cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.26']",@@default_namespaces)
    
      if group_number
        errors << match_value(childAct, "cda:id/@root", "group_number", self.group_number.to_s)
      end
      
      if insurance_type 
        code = REXML::XPath.first(childAct,"cda:code[@codeSystem='2.16.840.1.113883.6.255.1336']",@@default_namespaces)
        errors.concat insurance_type.validate_c32(code)
      end
    
      if represented_organization 
        representedOrganization = REXML::XPath.first(childAct,
          "cda:performer[@typeCode='PRF']/cda:assignedEntity[@classCode='ASSIGNED']/cda:representedOrganization[@classCode='ORG']",@@default_namespaces)
        errors << match_value(representedOrganization, "cda:name", "represented_organization_name", self.represented_organization.to_s)
      end
      
      if self.insurance_provider_guarantor && insurance_provider_guarantor.has_any_data
        
        # insurance provider's represented organization test
        if represented_organization
          begin   
            errors << match_value(childAct, "cda:performer/@typeCode", "PRF", "PRF")
          rescue
            errors << ContentError.new(
              :section => 'Insurance Provider', 
              :error_message => 'Failed checking that the XML element''performer'' has attribute ''typeCode'' that is equal to ''PRF''',
              :type=>'error',
              :location => childAct.xpath)
          end    
        end
        
        # TODO start insurance provider's effective date test
        # end insurance provider's effective date test
        
        # insurance provider guarantor
        if insurance_provider_guarantor.person_name.first_name && insurance_provider_guarantor.person_name.last_name
          guarantor_name_element = REXML::XPath.first(childAct, 
            "cda:performer/cda:assignedEntity/cda:assignedPerson/cda:name[cda:given='#{self.insurance_provider_guarantor.person_name.first_name}' and cda:family='#{self.insurance_provider_guarantor.person_name.last_name}']",
            {'cda' => 'urn:hl7-org:v3'})
          if guarantor_name_element
            errors.concat(self.insurance_provider_guarantor.person_name.validate_c32(guarantor_name_element))
          else
            errors << ContentError.new(:section => 'insurance_provider', 
                                       :subsection => 'guarantor_name',
                                       :error_message => "Couldn't match the insurance provider guarantor's name",
                                       :type => 'error',
                                       :location => guarantor_name_element.xpath)
          end
        end
        
        # insurance provider subscriber
        #if insurance_provider_subscriber
        #  self.insurance_provider_subscriber.validate_c32(childAct)
        #end
       
      end

    rescue
      errors << ContentError.new(:section => 'Insurance Provider', 
                                 :error_message => 'Invalid, non-parsable XML for Insurance Provider data',
                                 :type=>'error',
                                 :location => document.xpath)
    end
    errors.compact
  end
  
  def to_c32(xml)
    xml.entry {
      xml.act("classCode" => "ACT", "moodCode" => "DEF") {
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.20", "assigningAuthorityName" => "CCD")
        xml.id("root" => group_number, "extension" => "GroupOrContract#")
        xml.code('code'=>'48768-6', 'displayName'=>'Payment Sources',
            'codeSystem'=>'2.16.840.1.113883.6.1' ,'codeSystemName'=>'LOINC')
        xml.statusCode('code'=>'completed')
        xml.entryRelationship("typeCode" => "COMP") {
          xml.act("classCode" => "ACT", "moodCode" => "EVN") {
            xml.templateId("root" => "2.16.840.1.113883.10.20.1.26")
            xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.5")
            xml.id("root" => group_number, "extension" => "GroupOrContract#")
            if insurance_type 
              xml.code("code" => insurance_type.code, 
                       "displayName" => insurance_type.name, 
                       "codeSystem" => "2.16.840.1.113883.6.255.1336", 
                       "codeSystemName" => "X12N-1336")
            else
              xml.code("nullFlavour"=>"NA")
            end
            xml.statusCode('code'=>'completed')
            
            # represented organization
            if represented_organization 
              xml.performer("typeCode" => "PRF") {
                xml.assignedEntity("classCode" => "ASSIGNED") {
                  xml.id('root'=>'2.16.840.1.113883.3.88.3.1')
                  xml.representedOrganization("classCode" => "ORG") {
                    xml.id("root" => "2.16.840.1.113883.19.5")
                    xml.name represented_organization
                  }
                }
              }
            end
            
            # guarantor is provided only if there is some non-nil, non-empty data
            if insurance_provider_guarantor && insurance_provider_guarantor.has_any_data
              attrs = (represented_organization) ? {} : {"typeCode" => "PRF"}
              xml.performer(attrs) {
                if !insurance_provider_guarantor.effective_date.blank?
                  xml.time("value" => insurance_provider_guarantor.effective_date.strftime("%Y%m%d"))
                end
                xml.assignedEntity {
                  xml.id
                  code_atts = {"code"=>"PAYOR","codeSystem" => "2.16.840.1.113883.5.110"}
                  if insurance_type && insurance_type.code == 'PP'
                      if insurance_provider_guarantor
                          code_atts['code']= "GUAR"
                      else
                          code_atts['code']= "PAT"
                      end
                  end
                  xml.code(code_atts)
                  xml.assignedPerson {
                    insurance_provider_guarantor.person_name.to_c32(xml)
                  }
                }
              }
            end
            
            # patient data is provided only if there is some non-nil, non-empty data
            if insurance_provider_patient && insurance_provider_patient.has_any_data
              xml.participant("typeCode" => "COV") {
                xml.participantRole("classCode" => "PAT") {
                  if coverage_role_type
                    xml.code("code" => coverage_role_type.code, 
                             "displayName" => coverage_role_type.name, 
                             "codeSystem" => "2.16.840.1.113883.5.111", 
                             "codeSystemName" => "RoleCode") 
                  end
                  xml.playingEntity {
                    insurance_provider_patient.person_name.andand.to_c32(xml)
                    if !insurance_provider_patient.date_of_birth.blank?
                      xml.sdtc(:birthTime, "value" => insurance_provider_patient.date_of_birth.strftime("%Y%m%d"))
                    end
                  }
                }
              }
            end
            
            insurance_provider_subscriber.andand.to_c32(xml)

          }
        }
      }
    }
  end
 
 
  def randomize(patient_info)
    self.insurance_provider_patient = InsuranceProviderPatient.new
    self.insurance_provider_patient.randomize(patient_info)

    self.insurance_provider_subscriber = InsuranceProviderSubscriber.new
    self.insurance_provider_subscriber.randomize()

    self.insurance_provider_guarantor = InsuranceProviderGuarantor.new
    self.insurance_provider_guarantor.randomize()

    self.role_class_relationship_formal_type = RoleClassRelationshipFormalType.find(:all).sort_by{rand}.first
    self.coverage_role_type = CoverageRoleType.find(:all).sort_by{rand}.first
    self.insurance_type = InsuranceType.find(:all).sort_by{rand}.first
    if (self.insurance_type_id != 606711552)
      self.group_number = nil
    else
      self.group_number = (100000000 + rand(8999999999)) #generates a random 9 digit group number
    end

    @organizations = ["Aetna", "Altius", "Anthem Blue Cross", "Health Net", "Medica", "Pacificare", "Unicare", "Lifewise", "CIGNIA", "Medical Mutual", "Harvard Pilgrim", "Humana", "MetLife"]
    self.represented_organization = @organizations.sort_by{rand}.first

  end
 
end
