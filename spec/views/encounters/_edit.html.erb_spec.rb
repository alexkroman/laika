require File.dirname(__FILE__) + '/../../spec_helper'

describe "encounters/_edit.html.erb" do
  fixtures :users

  before do
    EncounterType.stub!(:all).and_return([])
    IsoCountry.stub!(:all).and_return([])
    EncounterLocationCode.stub!(:all).and_return([])
  end

  describe "with an existing encounter (encounters/edit)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @encounter = Encounter.create!(:patient_data => @patient_data)
      @encounter.person_name = PersonName.new
      @encounter.address = Address.new
      @encounter.telecom = Telecom.new
    end

    it "should render the edit form with method PUT" do
      render :partial  => 'encounters/edit', :locals => {:encounter => @encounter,
                                                         :patient_data => @patient_data}
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
    end

    it "should render the edit form with method POST" do
      render :partial  => 'encounters/edit', :locals => {:encounter => @encounter,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_encounters_path(@patient_data)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


