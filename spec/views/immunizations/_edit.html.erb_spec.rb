require File.dirname(__FILE__) + '/../../spec_helper'

describe "immunizations/_edit.html.erb" do
  fixtures :users

  describe "with an existing immunization (immunizations/edit)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @immunization = Immunization.create!(:patient_data => @patient_data)
    end

    it "should render the edit form with PUT" do
      render :partial  => 'immunizations/edit', :locals => {:immunization => @immunization,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_immunization_path(@patient_data,@immunization)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing immunization (immunizations/new)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @immunization = Immunization.new
    end

    it "should render the edit form with POST" do
      render :partial  => 'immunizations/edit', :locals => {:immunization => @immunization,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_immunizations_path(@patient_data)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


