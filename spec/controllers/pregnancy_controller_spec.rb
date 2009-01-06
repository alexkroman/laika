require File.dirname(__FILE__) + '/../spec_helper'

describe PregnancyController do
  before do
    controller.stub!(:current_user).and_return(stub_model User)
  end

  it "should display the edit page" do
    pd = stub_model PatientData
    PatientData.stub!(:find).and_return(pd)

    get :edit, :patient_data_instance_id => 1

    assigns[:patient_data].should == pd
    response.should render_template("pregnancy/edit")
    response.layout.should be_nil
  end

  it "should update patient_data with pregnancy on" do
    pd = mock_model PatientData
    PatientData.stub!(:find).and_return(pd)

    pd.should_receive(:pregnant=).with(true)
    pd.should_receive(:save!)

    get :update, :patient_data_instance_id => pd.id, :pregnant => 'on'

    assigns[:patient_data].should == pd
  end

  it "should update patient_data with pregnancy off" do
    pd = mock_model PatientData
    PatientData.stub!(:find).and_return(pd)

    pd.should_receive(:pregnant=).with(false)
    pd.should_receive(:save!)

    get :update, :patient_data_instance_id => pd.id

    assigns[:patient_data].should == pd
  end

  it "should update patient_data with pregnancy nil" do
    pd = mock_model PatientData
    PatientData.stub!(:find).and_return(pd)

    pd.should_receive(:pregnant=).with(nil)
    pd.should_receive(:save!)

    get :destroy, :patient_data_instance_id => pd.id

    assigns[:patient_data].should == pd
  end

end
