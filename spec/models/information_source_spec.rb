require File.dirname(__FILE__) + '/../spec_helper'

describe InformationSource, "Must be present" do
  fixtures :information_sources, :person_names
  
  before(:each) do
    @information_source = information_sources(:jennifer_thompson_information_source)
  end


  
  it "should be able to validate itself" do
      document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/jenny_thompson_information_source.xml'))
      errors = @information_source.validate_c32(document.root)
      errors.should be_empty
  end
  
  it "should fail if an author element is not present" do
      document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/jenny_thompson_no_info_source.xml'))
      errors = @information_source.validate_c32(document.root)
      errors.should_not be_empty      
  end  
end

describe InformationSource, "can create a C32 representation of itself" do
  fixtures :information_sources, :person_names
  
  it "should create valid C32 content" do
    information_source = information_sources(:jennifer_thompson_information_source)
    
    buffer = ""
    xml = Builder::XmlMarkup.new(:target => buffer, :indent => 2)
    xml.ClinicalDocument("xsi:schemaLocation" => "urn:hl7-org:v3 http://xreg2.nist.gov:8080/hitspValidation/schema/cdar2c32/infrastructure/cda/C32_CDA.xsd", 
                         "xmlns" => "urn:hl7-org:v3", 
                         "xmlns:sdct" => "urn:hl7-org:sdct", 
                         "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance") do
      information_source.to_c32(xml)
    end
    document = REXML::Document.new(StringIO.new(buffer))
    puts buffer
    errors = information_source.validate_c32(document.root)
    puts errors.map { |e| e.error_message }.join(' ')
    errors.should be_empty
  end
end