require File.dirname(__FILE__) + '/../../spec_helper'

describe "encounters/edit.html.erb" do
  fixtures :users

  describe "with an existing encounter (encounters/edit)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @encounter = Encounter.create!(:patient_data => @patient_data)
      @encounter.person_name = PersonName.new
      @encounter.address = Address.new
      @encounter.telecom = Telecom.new
      assigns[:encounter] = @encounter
      assigns[:patient_data] = @patient_data
    end

    it "should render the edit form with method PUT" do
      render 'encounters/edit'
      response.should have_tag("form[action=#{patient_data_instance_encounter_path(@patient_data,@encounter)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing encounter (encounters/new)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @encounter = Encounter.new
      @encounter.person_name = PersonName.new
      @encounter.address = Address.new
      @encounter.telecom = Telecom.new
      assigns[:encounter] = @encounter
      assigns[:patient_data] = @patient_data
    end

    it "should render the edit form with method POST" do
      render 'encounters/edit'
      response.should have_tag("form[action=#{patient_data_instance_encounters_path(@patient_data)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


