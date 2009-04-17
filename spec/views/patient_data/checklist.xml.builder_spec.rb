require File.dirname(__FILE__) + '/../../spec_helper'

describe "patients/checklist.xml.builder" do
  it "should render patients xml" do
    patient = mock_model(Patient)
    patient.stub!(:to_c32).and_return('xxx')
    assigns[:patient] = patient
    render "patients/checklist.xml.builder"
    response.body.should == 'xxx'
  end
end


