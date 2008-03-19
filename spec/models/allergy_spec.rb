require File.dirname(__FILE__) + '/../spec_helper'

describe Allergy, "it can validate allergy entries in a C32" do
  fixtures :allergies, :severity_terms, :adverse_event_types
  
  it "should verify an allergy matches in a C32 doc" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/allergies/joe_allergy.xml'))
    joe_allergy = allergies(:joes_allergy)
    errors = joe_allergy.validate_c32(document)
    errors.should be_empty
  end
  
  it "should verify when there are no known allergies" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/allergies/no_known_allergies.xml'))
    allergy = Allergy.new
    errors = allergy.check_no_known_allergies_c32(document)
    errors.should be_empty
  end
end
