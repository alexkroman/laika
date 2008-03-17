require File.dirname(__FILE__) + '/../spec_helper'

describe Medication, 'it can validate medication elements in a C32' do
  fixtures :medications, :code_systems, :medication_types
  
  it "should verify a medication in a C32 doc" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/medications/jenny_medication.xml'))
    med = medications(:jennifer_thompson_medication)
    errors = med.validate_c32(document)
    errors.should be_empty
  end
end