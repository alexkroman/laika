require File.dirname(__FILE__) + '/../spec_helper'

describe LanguagesController do
  fixtures :patient_data, :languages

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should assign @language on get new" do
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:language].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.languages.first.id.to_s
    response.should render_template('languages/edit')
  end

  it "should assign @language on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.languages.first.id.to_s
    assigns[:language].should == @patient_data.languages.first
  end

  it "should render create template on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('languages/create')
  end

  it "should assign @language on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:language].should_not be_new_record
  end

  it "should add an language on post create" do
    old_language_count = @patient_data.languages.count
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    @patient_data.languages(true).count.should == old_language_count + 1
  end

  it "should render show partial on put update" do
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.languages.first.id.to_s
    response.should render_template('languages/_show')
  end

  it "should update language on put update" do
    existing_language = @patient_data.languages.first
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => existing_language.id.to_s,
      :language => { :iso_language_id => '1234' }
    existing_language.reload
    existing_language.iso_language_id.should == 1234
  end

  it "should remove from @patient_data.languages on delete destroy" do
    existing_language = @patient_data.languages.first
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s, :id => existing_language.id.to_s
    @patient_data.languages(true).should_not include(existing_language)
  end

end

