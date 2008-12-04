class Language < ActiveRecord::Base

  belongs_to :patient_data
  belongs_to :iso_country
  belongs_to :iso_language
  belongs_to :language_ability_mode

  include MatchHelper

  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}

  def requirements
    {
      :iso_language_id => :required,
      :iso_country_id => :required,
      :preference => :required,
    }
  end

  #Reimplementing from MatchHelper
  def section_name
    "Languages Module"
  end

  def validate_c32(document)
    errors = []
    begin
      language_communication_element = REXML::XPath.first(document, "//cda:recordTarget/cda:patientRole/cda:patient/cda:languageCommunication[cda:languageCode/@code='#{language_code}']", @@default_namespaces)
      if language_communication_element
        if language_ability_mode
          errors << match_value(language_communication_element, 
                                "cda:modeCode/@code", 
                                "language_ability_mode", 
                                self.language_ability_mode.code)
        end
        if preference
          errors << match_value(language_communication_element, 
                                "cda:preferenceInd/@value", 
                                "preference", 
                                self.preference.to_s)        
        end
      else
        errors << ContentError.new(:section => 'languages', 
                                   :error_message => "No language found for #{language_code}",
                                   :location=>document.xpath)
      end
    rescue
      errors << ContentError.new(:section => 'languages', 
                                 :error_message => 'Invalid, non-parsable XML for language data',
                                 :type=>'error',
                                 :location => document.xpath)
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
      if iso_language && iso_country  
        xml.languageCode("code" => iso_language.code + "-" + iso_country.code)
      end 
      if language_ability_mode   
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

  def randomize()
    self.iso_country = IsoCountry.find(:all).sort_by{rand}.first
    self.iso_language = IsoLanguage.find(:all).sort_by{rand}.first
    self.language_ability_mode = LanguageAbilityMode.find(:all).sort_by{rand}.first
    self.preference = false
  end

end
