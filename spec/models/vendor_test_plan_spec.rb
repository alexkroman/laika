require File.dirname(__FILE__) + '/../spec_helper'

describe VendorTestPlan do
  fixtures :vendor_test_plans, :patient_data, :registration_information,
           :document_locations, :vendors, :person_names, :addresses
  
  before(:each) do
    @vendor_test_plan = vendor_test_plans(:test_plan)
    @clinical_document = ClinicalDocument.new(:doc_type => 'CCD')
    @clinical_document.stub!(:full_filename).and_return(RAILS_ROOT + '/spec/test_data/steve_ccd.xml')
    @vendor_test_plan.clinical_document = @clinical_document
  end

  it "should be able to verify a valid CCD" do
    results = @vendor_test_plan.validate_clinical_document_content
    results.should have_key(document_locations(:first_name))
    results[document_locations(:first_name)].should be_true
    results.should have_key(document_locations(:last_name))
    results[document_locations(:last_name)].should be_true
  end
end
