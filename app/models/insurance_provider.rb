class InsuranceProvider < ActiveRecord::Base
  
  strip_attributes!

  belongs_to :patient_data
  belongs_to :insurance_type
  
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
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.20'", "assigningAuthorityName" => "CCD")
        xml.entryRelationship("typeCode" => "COMP") {
          xml.act("classCode" => "ACT", "moodCode" => "EVN") {
            xml.templateId("root" => "2.16.840.1.113883.10.20.1.26")
            xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.5")
            if insurance_type != nil
              xml.code("code" => insurance_type.code, 
                       "displayName" => insurance_type.name, 
                       "codeSystem" => "2.16.840.1.113883.6.255.1336", 
                       "codeSystemName" => "X12N-1336")
            end
            if represented_organization != nil
              xml.performer("typeCode" => "PRF") {
                xml.assignedEntity("classCode" => "ASSIGNED") {
                  xml.representedOrganization("classCode" => "ORG") {
                    xml.name represented_organization
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
