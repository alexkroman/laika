require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationHelper do
  it "should return a HTTP method of post when a AR model is new" do
    helper.http_method(PatientData.new).should == 'post'
  end
  
  it "should return a HTTP method of put when a AR model is not new" do
    mock_model = mock("a_model")
    mock_model.stub!(:new_record?).and_return(false)
    helper.http_method(mock_model).should == 'put'
  end
  
end