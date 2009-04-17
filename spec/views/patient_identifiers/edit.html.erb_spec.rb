require File.dirname(__FILE__) + '/../../spec_helper'

describe "patient_identifiers/edit.html.erb" do
  fixtures :users

  describe "with an existing patient_identifier (patient_identifiers/edit)" do
    before do
      @patient = Patient.create!(:name => 'foo', :user => User.find(:first))
      @patient_identifier = @patient.patient_identifiers.create!
      assigns[:patient] = @patient
      assigns[:patient_identifier] = @patient_identifier
    end

    it "should render the edit form with method PUT" do
      render 'patient_identifiers/edit'
      response.should have_tag("form[action=#{patient_patient_identifier_path(@patient,@patient_identifier)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end

  end

  describe "without an existing patient_identifier (patient_identifiers/new)" do
    before do
      @patient = Patient.create!(:name => 'foo', :user => User.find(:first))
      @patient_identifier = PatientIdentifier.new
      assigns[:patient] = @patient
      assigns[:patient_identifier] = @patient_identifier
    end

    it "should render the edit form with method POST" do
      render 'patient_identifiers/edit'
      response.should have_tag("form[action=#{patient_patient_identifiers_path(@patient)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


