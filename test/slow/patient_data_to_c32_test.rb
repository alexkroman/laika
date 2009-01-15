require File.dirname(__FILE__) + '/../test_helper.rb'

class PatientDataTest < Test::Unit::TestCase
  # XXX This is slow and clumsy, it was written to catch regressions in to_c32
  # for a refactor (SF ticket 2496513). Ideally there would be separate tests for
  # each section. I dumped the output of Joe Smith's C32 data to a file using the
  # pre-refactor implementation, as it's the simplest way to ensure that the
  # output hasn't changed.
  #
  # If you need to run only this test repeatedly you can comment out the fixtures
  # after the first run.
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
relationships religions results result_type_codes role_class_relationship_formal_types
roles severity_terms snowmed_problems supports telecoms user_roles users vaccines
vendors zip_codes
  ]

  def setup
    @patient_data = PatientData.find_by_name("Joe Smith")
    @dumped_document = File.open(File.dirname(__FILE__) + '/../data/joe_c32_dump.xml')
  end

  def test_to_c32
    assert_equal @dumped_document.read, @patient_data.to_c32
  end
end

