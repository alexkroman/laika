require File.dirname(__FILE__) + '/../spec_helper'

describe XdsPatientsController do
  before { controller.stub!(:current_user).and_return mock_model(User) }

  it "reads existing entries from the XDS server"
  it "adds a document to the XDS server"

  it "retrieves a patient record" do
    PatientData.should_receive(:find).with('123')
    post :create, :patient_data_id => '123'
  end

end

