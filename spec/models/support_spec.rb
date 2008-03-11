require File.dirname(__FILE__) + '/../spec_helper'

describe Support, "it can validate a support in a C32" do
  fixtures :relationships, :contact_types, :person_names, 
           :addresses, :telecoms, :iso_countries, :supports
           
  it "should verify a support matches in a C32 document" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/jenny_support.xml'))
    support = supports(:jennifer_thompson_husband)
    errors = support.validate_c32(document.root)
    errors.should be_empty
  end
end