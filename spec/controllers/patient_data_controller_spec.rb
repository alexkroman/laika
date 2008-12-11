require File.dirname(__FILE__) + '/../spec_helper'

describe PatientDataController do

  before(:each) do
    controller.stub!(:current_user).and_return(mock_model(User))
  end

  it "should create a named template" do
    count = PatientData.count
    post :create, :patient_data => {:name => 'my awesome template'}
    PatientData.count.should == count + 1
  end

  it "should not permit creation of a nameless template" do
    post :create, :patient_data => {:name => ''}
    flash[:notice].should match(/validation failed/i)
    response.should redirect_to patient_data_url
  end

  it "should return xml content as downloadable" do
    PatientData.stub!(:find).and_return(PatientData.new)
    get :show, :id => 1, :format => 'xml'
    response.headers['type'].should == 'application/x-download'
  end

end
