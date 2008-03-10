require File.dirname(__FILE__) + '/../spec_helper'

describe Provider, "can validate itself" do
  fixtures :providers,:provider_roles,:provider_types, :person_names
  
  
  before(:each) do
    @provider = providers(:rn_mary_smith)
  end  
  
  it "should validate without errors" do
      document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/jenny_healthcare_provider.xml'))
      errors = @provider.validate_c32(document.root)
      errors.should be_empty
      
  end 
  
  
  
end