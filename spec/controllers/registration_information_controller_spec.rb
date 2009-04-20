require File.dirname(__FILE__) + '/../spec_helper'

describe RegistrationInformationController do
  fixtures :patients, :registration_information

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient = patients(:joe_smith)
  end

  it "should render edit template on get new" do
    get :new, :patient_id => @patient.id.to_s
    response.should render_template('registration_information/edit')
  end

  it "should assign @registration_information on get new" do
    get :new, :patient_id => @patient.id.to_s
    assigns[:registration_information].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_id => @patient.id.to_s
    response.should render_template('registration_information/edit')
  end

  it "should assign @registration_information on get edit" do
    get :edit, :patient_id => @patient.id.to_s
    assigns[:registration_information].should == @patient.registration_information
  end

  it "should render show partial on post create" do
    post :create, :patient_id => @patient.id.to_s
    response.should render_template('registration_information/_show')
  end

  it "should create registration_information on post create" do
    @patient.update_attributes!(:registration_information => nil)
    post :create, :patient_id => @patient.id.to_s
    @patient.registration_information(true).should_not be_nil
  end

  it "should render show partial on put update" do
    put :update, :patient_id => @patient.id.to_s
    response.should render_template('registration_information/_show')
  end

  it "should update registration_information on put update" do
    old_value = @patient.registration_information
    put :update, :patient_id => @patient.id.to_s,
        :registration_information => { :person_identifier => 'foobar' }
    @patient.registration_information(true).person_identifier.should == 'foobar'
  end

  it "should render show partial on delete destroy" do
    delete :destroy, :patient_id => @patient.id.to_s
    response.should render_template('registration_information/_show')
  end

  it "should not assign @registration_information on delete destroy" do
    delete :destroy, :patient_id => @patient.id.to_s
    assigns[:registration_information].should be_nil
  end

  it "should unset @patient.registration_information on delete destroy" do
    delete :destroy, :patient_id => @patient.id.to_s
    @patient.reload
    @patient.registration_information.should be_nil
  end

end

