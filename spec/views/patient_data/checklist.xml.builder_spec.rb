require File.dirname(__FILE__) + '/../../spec_helper'

describe "patient_data/checklist.xml.builder" do
  it "should render patient_data xml" do
    patient_data = mock_model(PatientData)
    patient_data.stub!(:to_c32).and_return('xxx')
    assigns[:patient] = patient_data
    render "patient_data/checklist.xml.builder"
    response.body.should == 'xxx'
  end
end


