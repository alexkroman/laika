require File.dirname(__FILE__) + '/../spec_helper'

describe DocumentLocation, "deals with variables in its XPath expression" do
  before(:each) do
    @document_location = DocumentLocation.new
  end
  
  it "should return an empty array when there are no variables" do
    @document_location.xpath_expression = '/foo/bar'
    @document_location.variable_names.should be_empty
  end
  
  it "should return a single element array for a single variable" do  
    @document_location.xpath_expression = '/foo/bar/text()=$splat'
    @document_location.variable_names.should have(1).item
    @document_location.variable_names[0].should == 'splat'
  end
  
  it "should find multiple variables and return them in an array" do  
    @document_location.xpath_expression = '/foo/bar/text()=$splat&&/foo/baz/text()=$buzz'
    @document_location.variable_names.should have(2).items
    @document_location.variable_names[0].should == 'splat'
    @document_location.variable_names[1].should == 'buzz'
  end
end

describe DocumentLocation, "binds variables" do
  before(:each) do
    @document_location = DocumentLocation.new(:section => 'registration_information')
    @patient_data = PatientData.new
    @registration_information = RegistrationInformation.new(:first_name => 'Andy',
                                                            :last_name => 'Gregorowicz')
    @patient_data.registration_information = @registration_information
  end
  
  it "should bind a single variable properly" do
    @document_location.xpath_expression = '/foo/bar/text()=$first_name'
    vars = @document_location.bind_variables(@patient_data)
    vars.should_not be_empty
    vars.should have_key("first_name")
    vars["first_name"].should ==  'Andy'
  end
  
  it "should return an empty hash if there are no variables" do
    @document_location.xpath_expression = "/foo/bar/text()='Andy'"
    vars = @document_location.bind_variables(@patient_data)
    vars.should be_empty
    vars.should be_a_kind_of(Hash)
  end
  
  it "should return nil when it can't bind a variable" do
    @document_location.xpath_expression = '/foo/bar/text()=$city'
    vars = @document_location.bind_variables(@patient_data)
    vars.should be_nil
  end
  
  it "should bind multiple values properly" do
    @document_location.xpath_expression = '/foo/first_name/text()=$first_name&&/foo/last_name/text()=$last_name'
    vars = @document_location.bind_variables(@patient_data)
    vars.should_not be_empty
    vars.should have_key("first_name")
    vars["first_name"].should ==  'Andy'
    vars.should have_key("last_name")
    vars["last_name"].should ==  'Gregorowicz'
  end
end
