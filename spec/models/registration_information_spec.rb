require File.dirname(__FILE__) + '/../spec_helper'

describe RegistrationInformation, "can vaildate it's content" do
  fixtures :patient_data, :registration_information, :person_names, :addresses,
           :telecoms, :genders
  
  it "should verify a person id matches in a C32 doc" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    joe_reg = registration_information(:joe_smith)
    errors = joe_reg.validate_c32(document)
    puts errors
    errors.should be_empty
  end
end

describe RegistrationInformation, "can create a C32 representation of itself" do
  fixtures :patient_data, :registration_information, :person_names, :addresses,
           :telecoms, :genders
  
  it "should create valid C32 content" do
    joe_reg = registration_information(:joe_smith)
    
    buffer = ""
    xml = Builder::XmlMarkup.new(:target => buffer, :indent => 2)
    xml.ClinicalDocument("xsi:schemaLocation" => "urn:hl7-org:v3 http://xreg2.nist.gov:8080/hitspValidation/schema/cdar2c32/infrastructure/cda/C32_CDA.xsd", 
                         "xmlns" => "urn:hl7-org:v3", 
                         "xmlns:sdct" => "urn:hl7-org:sdct", 
                         "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance") do
      xml.recordTarget do
        xml.patientRole do
          joe_reg.to_c32(xml)
        end
      end
    end
    document = REXML::Document.new(StringIO.new(buffer))
    errors = joe_reg.validate_c32(document.root)
    errors.should be_empty
  end
end