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
                  xml.representedOrganization("classCode" => "ORG") {\
                    xml.id("root" => "2.16.840.1.113883.19.5")
                    xml.name represented_organization
                  }
                }
              }
            end
            
            # guarantor is provided only if there is some non-nil, non-empty data
            if insurance_provider_guarantor  && insurance_provider_guarantor.has_any_data
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
            if insurance_provider_patient  && insurance_provider_patient.has_any_data
              xml.participant("typeCode" => "COV") {
                xml.participantRole("classCode" => "PAT") {
                  xml.code("code" => coverage_role_type.code, 
                           "displayName" => coverage_role_type.name, 
                           "codeSystem" => "2.16.840.1.113883.5.111", 
                           "codeSystemName" => "RoleCode") 
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
 
end
