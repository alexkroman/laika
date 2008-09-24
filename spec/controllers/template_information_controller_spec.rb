require File.dirname(__FILE__) + '/../spec_helper'

describe TemplateInformationController do

  before(:each) do
    @user = mock_model(User)
    @patient_data = mock_model(PatientData)
    PatientData.stub!(:find).with('1').and_return(@patient_data)
    controller.should be_an_instance_of(TemplateInformationController)
    controller.stub!(:current_user).and_return(@user)
  end
  
  describe "handling GET /edit" do

    def do_edit
      get :edit, :id => '1'
    end
  
    it "should be successful" do
      do_edit
      response.should be_success
    end

    it "should assign template information" do
      do_edit
      assigns[:patient_data].should equal(@patient_data)
    end

  end

  describe "handling PUT /update" do
    def do_update
      @params = {:name => 'New Template'}
      put :update, :id => '1', :template_information => @params
    end

    it "should update a patient" do
      @patient_data.should_receive(:update_attributes).and_return(true)
      do_update
      response.should render_template('_show')
    end

    it "should fail to update a patient" do
      @patient_data.should_receive(:update_attributes).and_return(false)
      do_update
      response.should render_template('_edit')
    end

  end

end
