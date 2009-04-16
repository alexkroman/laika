require File.dirname(__FILE__) + '/../spec_helper'

describe ResultsController do
  fixtures :patient_data, :abstract_results

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient = patient_data(:jennifer_thompson)
  end

  it "should assign @result on get new" do
    get :new, :patient_datum_id => @patient.id.to_s
    assigns[:result].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_datum_id => @patient.id.to_s, :id => @patient.all_results.first.id.to_s
    response.should render_template('results/edit')
  end

  it "should assign @result on get edit" do
    get :edit, :patient_datum_id => @patient.id.to_s, :id => @patient.all_results.first.id.to_s
    assigns[:result].should == @patient.all_results.first
  end

  it "should render create template on post create" do
    post :create, :patient_datum_id => @patient.id.to_s
    response.should render_template('results/create')
  end

  it "should assign @result on post create" do
    post :create, :patient_datum_id => @patient.id.to_s
    assigns[:result].should_not be_new_record
  end

  it "should add an result on post create" do
    old_result_count = @patient.all_results.count
    post :create, :patient_datum_id => @patient.id.to_s
    @patient.all_results(true).count.should == old_result_count + 1
  end

  it "should render show partial on put update" do
    put :update, :patient_datum_id => @patient.id.to_s, :id => @patient.all_results.first.id.to_s
    response.should render_template('results/_show')
  end

  it "should update result on put update" do
    existing_result = @patient.all_results.first
    put :update, :patient_datum_id => @patient.id.to_s, :id => existing_result.id.to_s,
      :result => { :result_code_display_name => 'foobar' }
    existing_result.reload
    existing_result.result_code_display_name.should == 'foobar'
  end

  it "should remove from @patient.all_results on delete destroy" do
    existing_result = @patient.all_results.first
    delete :destroy, :patient_datum_id => @patient.id.to_s, :id => existing_result.id.to_s
    @patient.all_results(true).should_not include(existing_result)
  end

end

