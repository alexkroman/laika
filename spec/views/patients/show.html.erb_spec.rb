require File.dirname(__FILE__) + '/../../spec_helper'

describe "patient_Data/show.html.erb" do
  fixtures %w[
act_status_codes addresses advance_directive_status_codes advance_directives
advance_directive_types adverse_event_types allergies allergy_status_codes
allergy_type_codes clinical_documents code_systems conditions contact_types
coverage_role_types encounter_location_codes encounters encounter_types ethnicities
genders immunizations information_sources insurance_provider_guarantors
insurance_provider_patients insurance_provider_subscribers insurance_providers
insurance_types iso_countries iso_languages iso_states kinds language_ability_modes
languages loinc_lab_codes marital_statuses medical_equipments medications
medication_types no_immunization_reasons patients person_names problem_types
procedures provider_roles providers provider_types races registration_information
relationships religions abstract_results result_type_codes role_class_relationship_formal_types
roles severity_terms supports telecoms user_roles users vaccines vendors zip_codes
  ]

  it "should render without errors" do
    assigns[:patient] = patients(:joe_smith)
    lambda { render "patients/show.html.erb" }.should_not raise_error
  end

end
