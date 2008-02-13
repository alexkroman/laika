require File.dirname(__FILE__) + '/../spec_helper'

describe Telecom, "can validate it's content" do
  fixtures :telecoms
  
  before(:each) do
    @telecom = telecoms(:jennifer_thompsons_telecom)
  end
  
  it "should properly verify telecoms with a use attribute" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/jenny_telecom_with_uses.xml'))
    errors = @telecom.validate_c32(document.root)
    errors.should be_empty
  end
  
  it "should properly verify telecoms with out a use attribute" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/jenny_telecom_no_uses.xml'))
    errors = @telecom.validate_c32(document.root)
    errors.should be_empty
  end
  
  it "should find errors when the use attribute is wrong" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/jenny_telecom_wrong_uses.xml'))
    errors = @telecom.validate_c32(document.root)
    errors.should_not be_empty
    errors.should have(2).errors
    errors[1].error_message.should.eql? "Expected use HP got HV"
  end
  
  it "should find errors when a telecom is missing" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/jenny_telecom_missing_mobile.xml'))
    errors = @telecom.validate_c32(document.root)
    errors.should_not be_empty
    errors.should have(1).error
    errors[0].error_message.should.eql? "Couldn't find the telecom for MC"
  end
end