class Condition < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :problem_type
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def to_c32(xml)
    
    xml.entry {
      xml.act("classCode" => "ACT", "moodCode" => "EVN") {
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.27", "assigningAuthorityName" => "CCD")
        xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.7", "assigningAuthorityName" => "HITSP/C32")
        xml.id
        xml.code("nullFlavor" => "NA")
        if start_event != nil || end_event != nil
          xml.effectiveTime {
            if start_event != nil 
              xml.low("value" => start_event.strftime("%Y%m%d"))
            end
            if end_event != nil
              xml.high("value" => end_event.strftime("%Y%m%d"))
            else
              xml.high("nullFlavor" => "UNK")
            end
          }
        end
        xml.entryRelationship("typeCode" => "SUBJ") {
          xml.observation("classCode" => "OBS", "moodCode" => "EVN") {
            xml.templateId("root" => "2.16.840.1.113883.10.20.1.28", "" => "CCD")
            xml.code("code" => problem_type.code, 
                     "displayName" => problem_type.name, 
                     "codeSystem" => "2.16.840.1.113883.6.96", 
                     "codeSystemName" => "SNOMED CT")
            xml.text {
              xml.reference("value" => "#problem-"+id.to_s)
            }
            xml.statusCode("code" => "completed")
          } 
        }
      }
    }

  end
  
end
