require File.dirname(__FILE__) + '/../spec_helper'

describe SupportsController do
  fixtures :patient_data, :supports

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should render edit template on get new" do
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('supports/edit')
  end

  it "should assign @support on get new" do
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:support].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('supports/edit')
  end

  it "should assign @support on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:support].should == @patient_data.support
  end

  it "should render show partial on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('supports/_show')
  end

  it "should not assign @support on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:support].should be_nil
  end

  it "should render show partial on put update" do
    put :update, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('supports/_show')
  end

  it "should not assign @support on put update" do
    put :update, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:support].should be_nil
  end

  it "should render show partial on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('supports/_show')
  end

  it "should not assign @support on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:support].should be_nil
  end

  it "should unset @patient_data.support on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s
    @patient_data.reload
    @patient_data.support.should be_nil
  end

end

