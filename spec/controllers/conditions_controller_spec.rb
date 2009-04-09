require File.dirname(__FILE__) + '/../spec_helper'

describe ConditionsController do
  fixtures :patient_data, :conditions

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should assign @condition on get new" do
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:condition].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.conditions.first.id.to_s
    response.should render_template('conditions/edit')
  end

  it "should assign @condition on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.conditions.first.id.to_s
    assigns[:condition].should == @patient_data.conditions.first
  end

  it "should render create template on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('conditions/create')
  end

  it "should assign @condition on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:condition].should_not be_new_record
  end

  it "should add an condition on post create" do
    old_condition_count = @patient_data.conditions.count
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    @patient_data.conditions(true).count.should == old_condition_count + 1
  end

  it "should render show partial on put update" do
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.conditions.first.id.to_s
    response.should render_template('conditions/_show')
  end

  it "should assign @condition on put update" do
    existing_condition = @patient_data.conditions.first
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => existing_condition.id.to_s
    assigns[:condition].should_not be_new_record
    assigns[:condition].should == existing_condition
  end

  it "should not assign @condition on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.conditions.first.id.to_s
    assigns[:condition].should be_nil
  end

  it "should remove from @patient_data.conditions on delete destroy" do
    existing_condition = @patient_data.conditions.first
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s, :id => existing_condition.id.to_s
    @patient_data.conditions(true).should_not include(existing_condition)
  end

end

