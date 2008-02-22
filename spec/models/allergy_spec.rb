require File.dirname(__FILE__) + '/../spec_helper'

describe Allergy, "it can validate allergy entries in a C32" do
  fixtures :allergies, :severity_terms, :adverse_event_types
  
  it "should verify an allergy matches in a C32 doc" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    joe_allergy = allergies(:joes_allergy)
    errors = joe_allergy.validate_c32(document)
    puts errors.map { |e| e.error_message }.join(' ')
    errors.should be_empty
  end
end
