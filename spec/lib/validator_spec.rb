require File.dirname(__FILE__) + '/../spec_helper'
require 'lib/validation.rb'
require 'lib/validators/c32_validator.rb'
require 'lib/validators/schema_validator.rb'
require 'lib/validators/schematron_validator.rb'
require 'lib/validators/umls_validator.rb'
C32_SCHEMA_VALIDATOR = Validators::Schema::Validator.new("C32 Schema Validator", "resources/schemas/infrastructure/cda/C32_CDA.xsd")
C32_SCHEMATRON_VALIDATOR = Validators::Schematron::CompiledValidator.new("C32 Schematron Validator","resources/schematron/c32_v2.1_errors.xslt")
CCD_SCHEMATRON_VALIDATOR = Validators::Schematron::CompiledValidator.new("CCD Schematron Validator","resources/schematron/ccd_errors.xslt")
C32_CONTENT_VALIDAOTR = Validators::C32Validation::Validator.new
UMLS_VALIDAOTR = Validators::Umls::UmlsValidator.new("warning")
describe Validation::Validator, "" do
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
  roles severity_terms supports telecoms user_roles users vaccines vendors zip_codes vendor_test_plans
    ]
  it "should be able to register  validators" do 
    
    #Validation.register_validator :c32, Validators::Umls::UmlsValidator.instance
    Validation.register_validator :C32, C32_CONTENT_VALIDAOTR
    Validation.register_validator :C32, C32_SCHEMA_VALIDATOR
    Validation.register_validator :C32, CCD_SCHEMATRON_VALIDATOR
    Validation.register_validator :C32, C32_SCHEMATRON_VALIDATOR

    Validation.get_validator(:c32).should_not be_nil
    Validation.get_validator(:c32).validators.length.should == 4
    
  end
  
  
   [ :david_carter, :emily_jones, :jennifer_thompson, :theodore_smith, :joe_smith, :will_haynes ].each do |patient|
       it "should round-trip validate #{patient} without errors or warnings" do
         record = patients(patient)
         document = REXML::Document.new(record.to_c32)
         Validation.register_validator :C32, C32_CONTENT_VALIDAOTR
         Validation.register_validator :C32, C32_SCHEMA_VALIDATOR
         Validation.register_validator :C32, CCD_SCHEMATRON_VALIDATOR
         Validation.register_validator :C32, C32_SCHEMATRON_VALIDATOR

         validator = Validation.get_validator(:c32)
         if validator.validators.length > 0
          errors = validator.validate(record,document)        
          errors.should be_empty
        end
      end
    end
  
end