require File.dirname(__FILE__) + '/../spec_helper'

describe Support, "it can validate a support in a C32" do
  fixtures :relationships, :contact_types, :person_names, 
           :addresses, :telecoms, :iso_countries, :supports
           
  it "should verify a support matches in a C32 document" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/supports/jenny_support.xml'))
    support = supports(:jennifer_thompson_husband)
    errors = support.validate_c32(document.root)
    errors.should be_empty
  end
end

describe Support, "can create a C32 representation of itself" do
  fixtures :relationships, :contact_types, :person_names, 
           :addresses, :telecoms, :iso_countries, :supports

  it "should create valid C32 content" do
    support = supports(:jennifer_thompson_husband)
    
    document = LaikaSpecHelper.build_c32 do |xml|
      support.to_c32(xml)
    end
    
    errors = support.validate_c32(document.root)
    errors.should be_empty
  end
end