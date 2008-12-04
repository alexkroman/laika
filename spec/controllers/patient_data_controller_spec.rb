require File.dirname(__FILE__) + '/../spec_helper'

describe PatientDataController do

  before(:each) do
    controller.stub!(:current_user).and_return(mock_model(User))
  end

  it "should return xml content as downloadable" do
    PatientData.stub!(:find).and_return(PatientData.new)
    get :show, :id => 1, :format => 'xml'
    response.headers['type'].should == 'application/x-download'
  end

end
