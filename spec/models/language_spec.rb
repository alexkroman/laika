require File.dirname(__FILE__) + '/../spec_helper'

describe Language, "it can validate language entries in a C32" do
  fixtures :languages, :iso_languages, :iso_countries, :language_ability_modes
  
  it "should verify an language matches in a C32 doc" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    joe_language = languages(:joe_smith_english_language)
    errors = joe_language.validate_c32(document)
    puts errors.map { |e| e.error_message }.join(' ')
    errors.should be_empty
  end
end

describe Language, "can create a C32 representation of itself" do
  fixtures :languages, :iso_languages, :iso_countries, :language_ability_modes
  
  it "should create valid C32 content" do
    joe_language = languages(:joe_smith_english_language)
    
    buffer = ""
    xml = Builder::XmlMarkup.new(:target => buffer, :indent => 2)
    xml.ClinicalDocument("xsi:schemaLocation" => "urn:hl7-org:v3 http://xreg2.nist.gov:8080/hitspValidation/schema/cdar2c32/infrastructure/cda/C32_CDA.xsd", 
                         "xmlns" => "urn:hl7-org:v3", 
                         "xmlns:sdct" => "urn:hl7-org:sdct", 
                         "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance") do
      xml.recordTarget do
        xml.patientRole do
          xml.patient do
            joe_language.to_c32(xml)
          end
        end
      end
    end
    document = REXML::Document.new(StringIO.new(buffer))
    errors = joe_language.validate_c32(document.root)
    errors.should be_empty
  end
end