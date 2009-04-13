require File.dirname(__FILE__) + '/../spec_helper'

describe InsuranceProviderGuarantorsController do
  fixtures :patient_data, :insurance_providers, :insurance_provider_guarantors

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should render edit template on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.insurance_provider_guarantors.first.id.to_s
    response.should render_template('insurance_provider_guarantors/edit')
  end

  it "should assign @insurance_provider_guarantor on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.insurance_provider_guarantors.first.id.to_s
    assigns[:insurance_provider_guarantor].should == @patient_data.insurance_provider_guarantors.first
  end

  it "should render show partial on put update" do
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.insurance_provider_guarantors.first.id.to_s
    response.should render_template('insurance_provider_guarantors/_show')
  end

  it "should update insurance_provider_guarantor on put update" do
    sentinel_date = Date.today
    existing_insurance_provider_guarantor = @patient_data.insurance_provider_guarantors.first
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => existing_insurance_provider_guarantor.id.to_s,
      :insurance_provider_guarantor => { :effective_date => sentinel_date }
    existing_insurance_provider_guarantor.reload
    existing_insurance_provider_guarantor.effective_date.should == sentinel_date
  end

end

