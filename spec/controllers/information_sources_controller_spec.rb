require File.dirname(__FILE__) + '/../spec_helper'

describe InformationSourcesController do
  fixtures :patient_data, :information_sources

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should render edit template on get new" do
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('information_sources/edit')
  end

  it "should assign @information_source on get new" do
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:information_source].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('information_sources/edit')
  end

  it "should assign @information_source on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:information_source].should == @patient_data.information_source
  end

  it "should render show partial on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('information_sources/_show')
  end

  it "should create information_source on post create" do
    @patient_data.update_attributes!(:information_source => nil)
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    @patient_data.information_source(true).should_not be_nil
  end

  it "should render show partial on put update" do
    put :update, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('information_sources/_show')
  end

  it "should update information_source on put update" do
    old_value = @patient_data.information_source
    put :update, :patient_data_instance_id => @patient_data.id.to_s,
        :information_source => { :organization_name => 'foobar' }
    @patient_data.information_source(true).organization_name.should == 'foobar'
  end

  it "should render show partial on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('information_sources/_show')
  end

  it "should not assign @information_source on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:information_source].should be_nil
  end

  it "should unset @patient_data.information_source on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s
    @patient_data.information_source(true).should be_nil
  end

end

