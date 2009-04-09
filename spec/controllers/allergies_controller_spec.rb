require File.dirname(__FILE__) + '/../spec_helper'

describe AllergiesController do
  fixtures :patient_data, :allergies

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should not update patient allergy flag on get new" do
    @patient_data.update_attributes!(:no_known_allergies => true)
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    @patient_data.reload
    @patient_data.no_known_allergies.should == true
  end

  it "should update patient allergy flag on post create" do
    @patient_data.update_attributes!(:no_known_allergies => true)
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    @patient_data.reload
    @patient_data.no_known_allergies.should == false
  end

  it "should assign @allergy on get new" do
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:allergy].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.allergies.first.id.to_s
    response.should render_template('allergies/edit')
  end

  it "should assign @allergy on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.allergies.first.id.to_s
    assigns[:allergy].should == @patient_data.allergies.first
  end

  it "should render create template on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('allergies/create')
  end

  it "should assign @allergy on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:allergy].should_not be_new_record
  end

  it "should add an allergy on post create" do
    old_allergy_count = @patient_data.allergies.count
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    @patient_data.allergies(true).count.should == old_allergy_count + 1
  end

  it "should render show partial on put update" do
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.allergies.first.id.to_s
    response.should render_template('allergies/_show')
  end

  it "should assign @allergy on put update" do
    existing_allergy = @patient_data.allergies.first
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => existing_allergy.id.to_s
    assigns[:allergy].should_not be_new_record
    assigns[:allergy].should == existing_allergy
  end

  it "should render no_known_allergies_link partial on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.allergies.first.id.to_s
    response.should render_template('allergies/_no_known_allergies_link')
  end

  it "should not assign @allergy on delete destroy" do
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.allergies.first.id.to_s
    assigns[:allergy].should be_nil
  end

  it "should remove from @patient_data.allergies on delete destroy" do
    existing_allergy = @patient_data.allergies.first
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s, :id => existing_allergy.id.to_s
    @patient_data.allergies(true).should_not include(existing_allergy)
  end

end

