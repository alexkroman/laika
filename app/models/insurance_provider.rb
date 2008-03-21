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
    
  end
  
  def to_c32(xml)
    xml.entry {
      xml.act("classCode" => "ACT", "moodCode" => "EVN") {
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.20", "assigningAuthorityName" => "CCD")
        xml.id("root" => group_number, "extension" => "GroupOrContract#")
        xml.code('code'=>'48768-6', 'displayName'=>'Payment Sources',
            'codeSystem'=>'2.16.840.1.113883.6.1' ,'codeSystemName'=>'LOINC')
        xml.statusCode('code'=>'completed')
        xml.entryRelationship("typeCode" => "COMP") {
          xml.act("classCode" => "ACT", "moodCode" => "EVN") {
            xml.templateId("root" => "2.16.840.1.113883.10.20.1.26")
            xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.5")
            if insurance_type 
              xml.code("code" => insurance_type.code, 
                       "displayName" => insurance_type.name, 
                       "codeSystem" => "2.16.840.1.113883.6.255.1336", 
                       "codeSystemName" => "X12N-1336")
            else
                xml.code("nullFlavour"=>"NA")
            end
            
            # represented organization
            if represented_organization != nil
              xml.performer("typeCode" => "PRF") {
                xml.assignedEntity("classCode" => "ASSIGNED") {
                  xml.representedOrganization("classCode" => "ORG") {
                    xml.name represented_organization
                  }
                }
              }
            end
            
            # patient data is provided only if there is some non-nil, non-empty data
            if insurance_provider_patient != nil && insurance_provider_patient.has_any_data
              xml.participant("typeCode" => "COV") {
                xml.participantRole("classCode" => "PAT") {
                  xml.code("code" => coverage_role_type.code, 
                           "displayName" => coverage_role_type.name, 
                           "codeSystem" => "2.16.840.1.113883.5.111", 
                           "codeSystemName" => "RoleCode") {
                    xml.playingEntity {
                      xml.name {
                        if insurance_provider_patient.person_name.name_prefix &&
                           insurance_provider_patient.person_name.name_prefix.size > 0
                          xml.prefix insurance_provider_patient.person_name.name_prefix
                        end
                        if insurance_provider_patient.person_name.first_name &&
                           insurance_provider_patient.person_name.first_name.size > 0
                          xml.given(insurance_provider_patient.person_name.first_name, "qualifier" => "CL")
                        end
                        if insurance_provider_patient.person_name.last_name &&
                           insurance_provider_patient.person_name.last_name.size > 0
                          xml.family (insurance_provider_patient.person_name.last_name, "qualifier" => "BR")
                        end
                        if insurance_provider_patient.person_name.name_suffix &&
                           insurance_provider_patient.person_name.name_suffix.size > 0
                          xml.prefix insurance_provider_patient.person_name.name_suffix
                        end
                      }
                      if !insurance_provider_patient.date_of_birth.blank?
                        xml.sdtc(:birthtime, "value" => insurance_provider_patient.date_of_birth.strftime("%Y%m%d"))
                      end
                    }
                  }
                }
              }
            end
            
            # subscriber data is provided only if there is some non-nil, non-empty data
            if insurance_provider_subscriber != nil && insurance_provider_subscriber.has_any_data
              xml.participant("typeCode" => "HLD") {
                xml.participantRole("classCode" => "IND") {
                  xml.playingEntity {
                    xml.name {
                      if insurance_provider_subscriber.person_name.name_prefix &&
                         insurance_provider_subscriber.person_name.name_prefix.size > 0
                        xml.prefix insurance_provider_subscriber.person_name.name_prefix
                      end
                      if insurance_provider_subscriber.person_name.first_name &&
                         insurance_provider_subscriber.person_name.first_name.size > 0
                        xml.given(insurance_provider_subscriber.person_name.first_name, "qualifier" => "CL")
                      end
                      if insurance_provider_subscriber.person_name.last_name &&
                         insurance_provider_subscriber.person_name.last_name.size > 0
                        xml.family (insurance_provider_subscriber.person_name.last_name, "qualifier" => "BR")
                      end
                      if insurance_provider_subscriber.person_name.name_suffix &&
                         insurance_provider_subscriber.person_name.name_suffix.size > 0
                        xml.prefix insurance_provider_subscriber.person_name.name_suffix
                      end
                    }
                    if !insurance_provider_subscriber.date_of_birth.blank?
                       xml.sdtc(:birthtime, "value" => insurance_provider_subscriber.date_of_birth.strftime("%Y%m%d"))
                    end
                  }
                }
              }
            end
            
            # guarantor is provided only if there is some non-nil, non-empty data
            if insurance_provider_guarantor != nil && insurance_provider_guarantor.has_any_data
              xml.performer("typeCode" => "PRF") {
                if !insurance_provider_guarantor.effective_date.blank?
                  xml.time("value" => insurance_provider_guarantor.effective_date.strftime("%Y%m%d"))
                end
                xml.assignedEntity {
                  xml.code("code" => role_class_relationship_formal_type.code, 
                           "displayName" => role_class_relationship_formal_type.code, 
                           "codeSystem" => "2.16.840.1.113883.5.110", 
                           "codeSystemName" => "RoleClass")
                  xml.assignedPerson {
                    xml.name {
                      if insurance_provider_guarantor.person_name.name_prefix &&
                         insurance_provider_guarantor.person_name.name_prefix.size > 0
                        xml.prefix insurance_provider_guarantor.person_name.name_prefix
                      end
                      if insurance_provider_guarantor.person_name.first_name &&
                         insurance_provider_guarantor.person_name.first_name.size > 0
                        xml.given(insurance_provider_guarantor.person_name.first_name, "qualifier" => "CL")
                      end
                      if insurance_provider_guarantor.person_name.last_name &&
                         insurance_provider_guarantor.person_name.last_name.size > 0
                        xml.family (insurance_provider_guarantor.person_name.last_name, "qualifier" => "BR")
                      end
                      if insurance_provider_guarantor.person_name.name_suffix &&
                         insurance_provider_guarantor.person_name.name_suffix.size > 0
                        xml.prefix insurance_provider_guarantor.person_name.name_suffix
                      end
                    }
                  }
                }
              }
            end
          }
        }
      }
    }
  end
 
end
