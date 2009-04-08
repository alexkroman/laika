require File.dirname(__FILE__) + '/../spec_helper'

describe AdvanceDirectivesController do
  fixtures :patient_data, :advance_directives

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should render edit template on get new" do
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('advance_directives/edit')
  end

  it "should assign @advance_directive on get new" do
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:advance_directive].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('advance_directives/edit')
  end

  it "should assign @advance_directive on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:advance_directive].should == @patient_data.advance_directive
  end

  it "should render show template on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('advance_directives/show')
  end

  it "should assign @advance_directive on post create" do
    old_advance_directive = @patient_data.advance_directive
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:advance_directive].should_not be_new_record
    assigns[:advance_directive].should_not == old_advance_directive
  end

  it "should render show template on put update" do
    put :update, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('advance_directives/show')
  end

  it "should assign @advance_directive on put update" do
    old_advance_directive = @patient_data.advance_directive
    put :update, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:advance_directive].should_not be_new_record
    assigns[:advance_directive].should == old_advance_directive
  end

  it "should render show template on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('advance_directives/show')
  end

  it "should not assign @advance_directive on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:advance_directive].should be_nil
  end

  it "should unset @patient_data.advance_directive on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s
    @patient_data.reload
    @patient_data.advance_directive.should be_nil
  end

end

