require File.dirname(__FILE__) + '/../../spec_helper'

describe "immunizations/edit.html.erb" do
  fixtures :users

  describe "with an existing immunization (immunizations/edit)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @immunization = Immunization.create!(:patient_data => @patient_data)
      assigns[:immunization] = @immunization
      assigns[:patient_data] = @patient_data
    end

    it "should render the edit form with PUT" do
      render 'immunizations/edit'
      response.should have_tag("form[action=#{patient_datum_immunization_path(@patient_data,@immunization)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing immunization (immunizations/new)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @immunization = Immunization.new
      assigns[:immunization] = @immunization
      assigns[:patient_data] = @patient_data
    end

    it "should render the edit form with POST" do
      render 'immunizations/edit'
      response.should have_tag("form[action=#{patient_datum_immunizations_path(@patient_data)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


