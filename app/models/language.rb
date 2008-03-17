class Language < ActiveRecord::Base
  belongs_to :patient_data
  belongs_to :iso_country
  belongs_to :iso_language
  belongs_to :language_ability_mode
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def validate_c32(document)
    errors = []
    language_communication_element = REXML::XPath.first(document, "//cda:recordTarget/cda:patientRole/cda:patient/cda:languageCommunication[cda:languageCode/@code='#{language_code}']", @@default_namespaces)
    if language_communication_element
      if language_ability_mode
        errors << match_value(language_communication_element, "cda:modeCode/@code", "language_ability_mode", self.language_ability_mode.code)
      end
      if preference
        errors << match_value(language_communication_element, "cda:preferenceInd/@value", "preference", self.preference.to_s)        
      end
    else
      errors << ContentError.new(:section => 'languages', :error_message => "No language found for #{language_code}",
                                :location=>document.xpath)
    end
    errors.compact
  end
  
  # Creates the language code as specified in Section 2.2 of the CCD Spec
  def language_code
    if self.iso_country
      "#{self.iso_language.code}-#{self.iso_country.code}"
    else
      self.iso_language.code      
    end
  end
  
  def to_c32(xml)
      xml.languageCommunication {
         xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.2")
         xml.languageCode("code" => iso_language.code + "-" +iso_country.code,
                                     "displayName" => iso_language.name) 
         if language_ability_mode &&  language_ability_mode.code
            
            xml.modeCode("code" => language_ability_mode.code, 
                         "displayName" =>  language_ability_mode.name,
                         "codeSystem" => "2.16.840.1.113883.5.60",
                         "codeSystemName" => "LanguageAbilityMode")
         end
         if preference != nil
         xml.preferenceInd("value" => preference)
      end
     }  
  end
end
