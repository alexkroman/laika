require File.dirname(__FILE__) + '/../../spec_helper'

describe "medications/_edit.html.erb" do
  fixtures :users

  before do
    assigns[:medicationTypes] = []
    assigns[:medicationCodeSystems] = []
  end

  describe "with an existing medication (medications/edit)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @medication = Medication.create!(:patient_data => @patient_data)
    end

    it "should render the edit form with method PUT" do
      render :partial  => 'medications/edit', :locals => {:medication => @medication,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_medication_path(@patient_data,@medication)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing medication (medications/new)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @medication = Medication.new
    end

    it "should render the edit form with method POST" do
      render :partial  => 'medications/edit', :locals => {:medication => @medication,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_medications_path(@patient_data)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


