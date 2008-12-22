require File.dirname(__FILE__) + '/../spec_helper'

describe PatientDataController do
  fixtures :users

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
    pd_mock = mock('pd')
    pd_mock.stub!(:to_c32).and_return('<ClinicalDocument/>')
    pd_mock.stub!(:vendor_test_plan_id).and_return(false)
    pd_mock.stub!(:id).and_return(7)
    PatientData.stub!(:find).and_return(pd_mock)
    get :show, :id => 1, :format => 'xml'
    response.headers['type'].should == 'application/x-download'
  end

  it "should update template name" do
    template = PatientData.create!(:name => 'Me', :user => users(:alex_kroman))
    put :update, :id => template.id, :patient_data => { :name => 'You' }
    template.reload
    template.name.should == 'You'
  end

end
