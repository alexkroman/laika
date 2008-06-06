class Encounter < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  
  include PersonLike
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"} 
  
  def validate_c32(document)
    errors=[]  
    errors.compact
  end
  
  def to_c32(xml)    
  	xml.entry('typeCode'=>'DRIV') {     
      xml.encounter('classCode'=>'ENC', 'moodCode'=>'EVN') { 
        xml.templateId('root' => '2.16.840.1.113883.10.20.1.21', 
                       'assigningAuthorityName' => 'CCD')
        xml.templateId('root' => '2.16.840.1.113883.3.88.11.32.17',
                       'assigningAuthorityName' => 'HITSP/C32') 
        xml.id ('root' => encounter_id)
        if encounter_date != nil 
          xml.effectiveTime {
            xml.low('value'=> encounter_date.strftime('%Y%m%d'))
          }
        end
        xml.participant('typeCode'=>'PRF') {
          xml.participantRole('classCode' => 'PROV') {        
            xml.playingEntity {
              address.andand.to_c32(xml)
              telecom.andand.to_c32(xml)  
              xml.playingEntity do
                person_name.andand.to_c32(xml)
              end
            }
          }
        }
      }
    }
  end
  
end