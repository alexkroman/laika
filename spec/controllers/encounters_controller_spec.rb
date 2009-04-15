require File.dirname(__FILE__) + '/../spec_helper'

describe EncountersController do
  fixtures :patient_data, :encounters

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should assign @encounter on get new" do
    get :new, :patient_datum_id => @patient_data.id.to_s
    assigns[:encounter].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_datum_id => @patient_data.id.to_s, :id => @patient_data.encounters.first.id.to_s
    response.should render_template('encounters/edit')
  end

  it "should assign @encounter on get edit" do
    get :edit, :patient_datum_id => @patient_data.id.to_s, :id => @patient_data.encounters.first.id.to_s
    assigns[:encounter].should == @patient_data.encounters.first
  end

  it "should render create template on post create" do
    post :create, :patient_datum_id => @patient_data.id.to_s
    response.should render_template('encounters/create')
  end

  it "should assign @encounter on post create" do
    post :create, :patient_datum_id => @patient_data.id.to_s
    assigns[:encounter].should_not be_new_record
  end

  it "should add an encounter on post create" do
    old_encounter_count = @patient_data.encounters.count
    post :create, :patient_datum_id => @patient_data.id.to_s
    @patient_data.encounters(true).count.should == old_encounter_count + 1
  end

  it "should render show partial on put update" do
    put :update, :patient_datum_id => @patient_data.id.to_s, :id => @patient_data.encounters.first.id.to_s
    response.should render_template('encounters/_show')
  end

  it "should update encounter on put update" do
    existing_encounter = @patient_data.encounters.first
    put :update, :patient_datum_id => @patient_data.id.to_s, :id => existing_encounter.id.to_s,
      :encounter => { :name => 'foobar'}
    existing_encounter.reload
    existing_encounter.name.should == 'foobar'
  end

  it "should remove from @patient_data.encounters on delete destroy" do
    existing_encounter = @patient_data.encounters.first
    delete :destroy, :patient_datum_id => @patient_data.id.to_s, :id => existing_encounter.id.to_s
    @patient_data.encounters(true).should_not include(existing_encounter)
  end

end

