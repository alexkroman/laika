require File.dirname(__FILE__) + '/../spec_helper'
require "lib/validators/c32_validator"

describe PatientData do
  fixtures :patient_data, :registration_information, :person_names, :addresses, :telecoms, :genders
  before(:each) do
     @patient_data = patient_data(:joe_smith) 
  end

  it "should require a name" do
    @patient_data.name = ''
    @patient_data.should_not be_valid
  end

  describe "copied with .copy()" do
  
    before(:each) do
       @patient_data_copy = @patient_data.copy
    end
 
  
    it "should have the same name as its source" do
      @patient_data_copy.name.should == @patient_data.name
    end
    
    it "should have the same registration information as its source" do
      @patient_data_copy.registration_information.should_not be_nil
      @patient_data_copy.registration_information.gender.code.should ==
        @patient_data.registration_information.gender.code
      @patient_data_copy.registration_information.person_name.first_name.should ==
        @patient_data.registration_information.person_name.first_name
      @patient_data_copy.registration_information.person_name.last_name.should ==
        @patient_data.registration_information.person_name.last_name
    end
  end
end

describe PatientData, "with built-in records" do
  fixtures %w[
act_status_codes addresses advance_directive_status_codes advance_directives
advance_directive_types adverse_event_types allergies allergy_status_codes
allergy_type_codes clinical_documents code_systems conditions contact_types
coverage_role_types encounter_location_codes encounters encounter_types ethnicities
genders immunizations information_sources insurance_provider_guarantors
insurance_provider_patients insurance_provider_subscribers insurance_providers
insurance_types iso_countries iso_languages iso_states kinds language_ability_modes
languages loinc_lab_codes marital_statuses medical_equipments medications
medication_types no_immunization_reasons patient_data person_names problem_types
procedures provider_roles providers provider_types races registration_information
relationships religions abstract_results result_type_codes role_class_relationship_formal_types
roles severity_terms supports telecoms user_roles users vaccines vendors zip_codes
  ]

  [ :david_carter, :emily_jones, :jennifer_thompson, :theodore_smith, :joe_smith, :will_haynes ].each do |patient|
    it "should round-trip validate #{patient} without errors or warnings" do
      record = patient_data(patient)
      document = REXML::Document.new(record.to_c32)
      record.validate_c32(document).should be_empty
    end
  end

  it "should validate different patients with errors" do
    patient1 = patient_data(:david_carter)
    patient2 = patient_data(:joe_smith)
    document1 = REXML::Document.new(patient1.to_c32)
    document2 = REXML::Document.new(patient2.to_c32)

    # validate themselves (no errors)
    patient1.validate_c32(document1).should be_empty
    patient2.validate_c32(document2).should be_empty

    # validate each other (has errors)
    patient2.validate_c32(document1).should_not be_empty
    patient1.validate_c32(document2).should_not be_empty
  end

  it "should fail to validate when medication entries differ" do
    pending "SF ticket 2101046"
    record = patient_data(:jennifer_thompson)
    document = REXML::Document.new(record.to_c32)
    record.medications.clear
    record.validate_c32(document).should_not be_empty
  end

  it "should validate identical patients with 3 conditions" do
    record = patient_data(:joe_smith)
    record.conditions.clear
    3.times do |i|
      record.conditions << Condition.new(
        :start_event => Date.today + i,
        :free_text_name => "condition #{i}",
        :problem_type => ProblemType.find(:first)
      )
    end
    document = REXML::Document.new(record.to_c32)
    record.validate_c32(document).should be_empty
  end

  it "should refresh updated_at when a child record is updated" do
    record = patient_data(:david_carter)
    old_updated_at = record.updated_at
    record.conditions.first.update_attributes!(:free_text_name => 'something else')
    record.reload
    record.updated_at.should > old_updated_at
  end

end

