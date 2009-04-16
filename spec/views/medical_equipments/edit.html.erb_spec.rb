require File.dirname(__FILE__) + '/../../spec_helper'

describe "medical_equipment/edit.html.erb" do
  fixtures :users

  describe "with an existing medical_equipment (medical_equipments/edit)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @medical_equipment = MedicalEquipment.create!(:patient_data => @patient)
      assigns[:medical_equipment] = @medical_equipment
      assigns[:patient] = @patient
    end

    it "should render the edit form with method PUT" do
      render 'medical_equipments/edit'
      response.should have_tag("form[action=#{patient_datum_medical_equipment_path(@patient,@medical_equipment)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing medical_equipment (medical_equipments/new)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @medical_equipment = MedicalEquipment.new
      assigns[:medical_equipment] = @medical_equipment
      assigns[:patient] = @patient
    end

    it "should render the edit form with method POST" do
      render 'medical_equipments/edit'
      response.should have_tag("form[action=#{patient_datum_medical_equipments_path(@patient)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


