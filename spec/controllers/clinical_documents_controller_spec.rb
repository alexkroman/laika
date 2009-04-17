require File.dirname(__FILE__) + '/../spec_helper'

describe ClinicalDocumentsController do

  before(:each) do
    controller.stub!(:current_user).and_return(mock_model(User))
  end

  it "should not create clinical documents when no file upload data is provided" do
    Patient.stub!(:find).and_return(Patient.new)
    vtp = VendorTestPlan.create
    post :create, :vendor_test_plan_id => vtp.id, :clinical_document => { :uploaded_data => ''}
    vtp.reload
    assert_nil vtp.clinical_document
  end

end
