class Immunization < ActiveRecord::Base
  strip_attributes!

  belongs_to :vaccine
  belongs_to :no_immunization_reason
  belongs_to :patient_data
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"} 
  
  def validate_c32(document)
    errors=[]  
    errors.compact
  end
  
  def to_c32(xml)    
    xml.entry('typeCode'=>'DRIV') {
      xml.substanceAdministration('classCode' => 'SBADM', 'moodCode' => 'EVN', 'negationInd' => refusal) {        
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.24", "assigningAuthorityName" => "CCD")
        xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.14", "assigningAuthorityName" => "HITSP/C32")
        xml.id('root'=>'41755f58-d7c0-4aab-9f7c-a3a5d8df4581')
        xml.statusCode('code' => 'completed')
        if administration_date != nil 
          xml.effectiveTime ('xsi:type' => "IVL_TS") {
            xml.center('value' => administration_date.strftime("%Y%m%d")) 
          }
	    end
	    xml.consumable {
		  xml.manufacturedProduct {
		    xml.templateId ('root' => '2.16.840.1.113883.10.20.1.53')
			xml.manufacturedMaterial{
			  if vaccine != nil
			    vaccine.andand.to_c32(xml)
              end 
	          xml.lotNumberText lot_number_text
	        }
          }
        }
        if no_immunization_reason == true
          no_immunization_reason.andand.to_c32(xml)
        end 
      }
    }
         
  end
  
end