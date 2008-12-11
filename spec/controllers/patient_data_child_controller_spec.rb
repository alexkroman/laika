require File.dirname(__FILE__) + '/../spec_helper'

class TestPatientDataChildController < PatientDataChildController
  def hiworld
    render :text => 'hiworld'
  end
end

describe TestPatientDataChildController do
  describe "as a subclass of PatientDataController" do
    before(:each) do
      controller.stub!(:current_user).and_return(mock_model(User))
    end

    it "should redirect when there is no patient_data_instance_id parameter" do
      get :hiworld
      response.should redirect_to(patient_data_url)
    end

    it "should not redirect when there is a patient_data_instance_id parameter" do
      PatientData.stub!(:find).and_return(mock_model(PatientData))
      get :hiworld, :patient_data_instance_id => 1
      response.should be_success
    end
  end
end
