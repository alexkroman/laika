require File.dirname(__FILE__) + '/../spec_helper'

describe XpathExpression, "can provide helpers for XML" do
  it "should find an element properly" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    patient_element = XpathExpression.execute_expression_against_element(document, 'registration_information_context', 'C32')
    patient_element.name.should  == 'patientRole'
  end
  
  it "should return nil when it can't find an element" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    first_name_element = XpathExpression.execute_expression_against_element(document, 'first_name', 'C32')
    first_name_element.should be_nil
  end
end

describe XpathExpression, "can match values in XML" do
  it "should return nil when a value properly matches" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    patient_element = XpathExpression.execute_expression_against_element(document, 'registration_information_context', 'C32')
    error = XpathExpression.match_value(patient_element, 'first_name', 'C32', 'Joe')
    error.should be_nil
  end
  
  it "should return an error string when the values don't match" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    patient_element = XpathExpression.execute_expression_against_element(document, 'registration_information_context', 'C32')
    error = XpathExpression.match_value(patient_element, 'first_name', 'C32', 'Billy')
    error.should_not be_nil
    error.should == "For First name expected Billy got Joe"
  end
  
  it "should return an error string when it can't find the XML it is looking for" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    patient_element = XpathExpression.execute_expression_against_element(document, 'registration_information_context', 'C32')
    error = XpathExpression.match_value(patient_element, 'broken_test_expression', 'C32', 'Billy')
    error.should_not be_nil
    error.should == "Couldn't find xml for Broken test expression"
  end
  
  it "should return nil when the expected value is nil" do
    error = XpathExpression.match_value(nil, nil, nil, nil)
    error.should be_nil
  end
end