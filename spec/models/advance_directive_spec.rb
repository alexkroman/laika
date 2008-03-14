require File.dirname(__FILE__) + '/../spec_helper'

describe AdvanceDirective, "can validate itself" do
  fixtures :advance_directives
  
  
  before(:each) do
    @ad = advance_directives(:jennifer_thompson_advance_directive)
  end  
  
  it "should validate without errors" do
     document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/jenny_advance_directive.xml'))
      errors = @ad.validate_c32(document.root)
      puts errors.map { |e| e.error_message }.join(' ')
      errors.should be_empty
      
  end 
  
  
  
end