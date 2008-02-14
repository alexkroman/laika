require File.dirname(__FILE__) + '/../spec_helper'

describe RegistrationInformation, "can vaildate it's content" do
  fixtures :patient_data, :registration_information, :person_names, :addresses,
           :telecoms, :genders
  
  it "should verify a person id matches in a C32 doc" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    joe_reg = registration_information(:joe_smith)
    errors = joe_reg.validate_c32(document)
    puts errors
    errors.should be_empty
  end
end