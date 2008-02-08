require File.dirname(__FILE__) + '/../spec_helper'


describe XmlHelper, "can match values in XML" do
  it "should return nil when a value properly matches" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    patient_element = REXML::XPath.first(document, '/cda:ClinicalDocument/cda:recordTarget/cda:patientRole', {'cda' => 'urn:hl7-org:v3'})
    error = XmlHelper.match_value(patient_element, 'cda:patient/cda:name/cda:given', 'Joe')
    error.should be_nil
  end
  
  it "should return an error string when the values don't match" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    patient_element = REXML::XPath.first(document, '/cda:ClinicalDocument/cda:recordTarget/cda:patientRole', {'cda' => 'urn:hl7-org:v3'})
    error = XmlHelper.match_value(patient_element, 'cda:patient/cda:name/cda:given', 'Billy')
    error.should_not be_nil
    error.should == "Expected Billy got Joe"
  end
  
  it "should return an error string when it can't find the XML it is looking for" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    patient_element = REXML::XPath.first(document, '/cda:ClinicalDocument/cda:recordTarget/cda:patientRole', {'cda' => 'urn:hl7-org:v3'})
    error = XmlHelper.match_value(patient_element, 'cda:patient/cda:foo', 'Billy')
    error.should_not be_nil
    error.should == "Couldn't find xml"
  end
  
  it "should return nil when the expected value is nil" do
    error = XmlHelper.match_value(nil, nil, nil)
    error.should be_nil
  end
end