require File.dirname(__FILE__) + '/../../spec_helper'

describe "medications/edit.html.erb" do
  fixtures :users

  describe "with an existing medication (medications/edit)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @medication = @patient.medications.create!
      assigns[:medication] = @medication
      assigns[:patient] = @patient
    end

    it "should render the edit form with method PUT" do
      render 'medications/edit'
      response.should have_tag("form[action=#{patient_datum_medication_path(@patient,@medication)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing medication (medications/new)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @medication = Medication.new
      assigns[:medication] = @medication
      assigns[:patient] = @patient
    end

    it "should render the edit form with method POST" do
      render 'medications/edit'
      response.should have_tag("form[action=#{patient_datum_medications_path(@patient)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


