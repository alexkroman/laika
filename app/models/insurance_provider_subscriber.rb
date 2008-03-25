class InsuranceProviderSubscriber < ActiveRecord::Base
  
  strip_attributes!

  belongs_to :insurance_provider
  include PersonLike
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def validate_c32(document)
    
  end
  
  def to_c32(xml)
    xml.participant("typeCode" => "HLD") {
      xml.participantRole("classCode" => "IND") {
        xml.id('root'=>'AssignAuthorityGUID', 'extension'=>subscriber_id)
        address.andand.to_c32(xml)
        telecom.andand.to_c32(xml)
        xml.playingEntity {
           
            person_name.andand.to_c32(xml)
          if !date_of_birth.blank?
             xml.sdtc(:birthTime, "value" => date_of_birth.strftime("%Y%m%d"))
          end
        }
      }
    }
  end
 
end
