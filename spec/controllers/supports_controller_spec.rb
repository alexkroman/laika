require File.dirname(__FILE__) + '/../spec_helper'

describe SupportsController do
  fixtures :patient_data, :supports

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should render edit template on get new" do
    get :new, :patient_datum_id => @patient_data.id.to_s
    response.should render_template('supports/edit')
  end

  it "should assign @support on get new" do
    get :new, :patient_datum_id => @patient_data.id.to_s
    assigns[:support].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_datum_id => @patient_data.id.to_s
    response.should render_template('supports/edit')
  end

  it "should assign @support on get edit" do
    get :edit, :patient_datum_id => @patient_data.id.to_s
    assigns[:support].should == @patient_data.support
  end

  it "should render show partial on post create" do
    post :create, :patient_datum_id => @patient_data.id.to_s
    response.should render_template('supports/_show')
  end

  it "should create support on post create" do
    @patient_data.update_attributes!(:support => nil)
    post :create, :patient_datum_id => @patient_data.id.to_s
    @patient_data.support(true).should_not be_nil
  end

  it "should render show partial on put update" do
    put :update, :patient_datum_id => @patient_data.id.to_s
    response.should render_template('supports/_show')
  end

  it "should update support on put update" do
    old_value = @patient_data.support
    put :update, :patient_datum_id => @patient_data.id.to_s,
        :support => { :name => 'foobar' }
    @patient_data.support(true).name.should == 'foobar'
  end

  it "should render show partial on delete destroy" do
    delete :destroy, :patient_datum_id => @patient_data.id.to_s
    response.should render_template('supports/_show')
  end

  it "should not assign @support on delete destroy" do
    delete :destroy, :patient_datum_id => @patient_data.id.to_s
    assigns[:support].should be_nil
  end

  it "should unset @patient_data.support on delete destroy" do
    delete :destroy, :patient_datum_id => @patient_data.id.to_s
    @patient_data.reload
    @patient_data.support.should be_nil
  end

end

