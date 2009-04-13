require File.dirname(__FILE__) + '/../spec_helper'

describe InsuranceProviderPatientsController do
  fixtures :patient_data, :insurance_providers, :insurance_provider_patients

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should render edit template on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.insurance_provider_patients.first.id.to_s
    response.should render_template('insurance_provider_patients/edit')
  end

  it "should assign @insurance_provider_patient on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.insurance_provider_patients.first.id.to_s
    assigns[:insurance_provider_patient].should == @patient_data.insurance_provider_patients.first
  end

  it "should render show partial on put update" do
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.insurance_provider_patients.first.id.to_s
    response.should render_template('insurance_provider_patients/_show')
  end

  it "should update insurance_provider_patient on put update" do
    existing_insurance_provider_patient = @patient_data.insurance_provider_patients.first
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => existing_insurance_provider_patient.id.to_s,
      :insurance_provider_patient => { :member_id => 'foobar' }
    existing_insurance_provider_patient.reload
    existing_insurance_provider_patient.member_id.should == 'foobar'
  end

end

