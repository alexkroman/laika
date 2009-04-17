require File.dirname(__FILE__) + '/../spec_helper'

class TestPatientChildrenController < PatientChildController
  def hiworld
    render :text => 'hiworld'
  end
end

describe TestPatientChildrenController do
  describe "as a subclass of PatientChildController" do
    before(:each) do
      controller.stub!(:current_user).and_return(mock_model(User))
    end

    it "should redirect when there is no patient_datum_id parameter" do
      get :hiworld
      response.should redirect_to(patients_url)
    end

    it "should not redirect when there is a patient_datum_id parameter" do
      Patient.stub!(:find).and_return(mock_model(Patient))
      get :hiworld, :patient_datum_id => 1
      response.should be_success
    end

    it "should determine the association based on controller name" do
      controller.send(:association_name).should == 'test_patient_children'
    end

    it "should determine the param key based on controller name" do
      controller.send(:param_key).should == :test_patient_child
    end

    it "should determine the instance var based on controller name" do
      controller.send(:instance_var_name).should == '@test_patient_child'
    end

  end
end
