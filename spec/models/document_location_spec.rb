require File.dirname(__FILE__) + '/../spec_helper'

describe DocumentLocation do
  before(:each) do
    @document_location = DocumentLocation.new
  end

  it "should be valid" do
    @document_location.should be_valid
  end
  
  it "should find variable names in it's XPath Expression" do
    @document_location.xpath_expression = '/foo/bar'
    @document_location.variable_names.should be_empty
    
    @document_location.xpath_expression = '/foo/bar/text()=$splat'
    @document_location.variable_names.should have(1).item
    @document_location.variable_names[0].should == 'splat'
    
    @document_location.xpath_expression = '/foo/bar/text()=$splat&&/foo/baz/text()=$buzz'
    @document_location.variable_names.should have(2).items
    @document_location.variable_names[0].should == 'splat'
    @document_location.variable_names[1].should == 'buzz'
  end
end
