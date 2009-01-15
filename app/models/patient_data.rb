class PatientData < ActiveRecord::Base
  module C32Component
    def to_c32(xml)
      if proxy_reflection.klass.respond_to? :c32_component
        proxy_reflection.klass.c32_component(self, xml) { map {|r| r.to_c32(xml)} }
      else
        map {|r| r.to_c32(xml)}
      end
    end
  end

  def self.has_c32_component(rel, args = {})
    has_many rel, args.merge(:extend => C32Component)
  end


  has_one    :registration_information
  has_one    :support
  has_one    :information_source
  has_one    :advance_directive

  has_c32_component   :languages
  has_c32_component   :providers
  has_c32_component   :medications

  has_c32_component   :allergies
  has_c32_component   :insurance_providers

  has_c32_component   :conditions

  has_many   :results
  has_c32_component   :immunizations
  has_c32_component   :encounters
  has_c32_component   :procedures
  has_c32_component   :medical_equipments

  belongs_to :vendor_test_plan
  belongs_to :user

  validates_presence_of :name

  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}

  # Results and Vital Signs are stored in the same 
  # table in the database, 'results'.
  # This grabs only the results, and omits vital signs
  def results_only
    results.find(:all, :conditions => "type = 'Result'")
  end

  # Results and Vital Signs are stored in the same 
  # table in the database, 'results'.
  # This grabs only the vital signs, and omits results
  def vital_signs
    results.find(:all, :conditions => "type = 'VitalSign'")
  end

  def validate_c32(clinical_document)

    errors = []

    # Registration information
    if self.registration_information != nil
      errors.concat(self.registration_information.validate_c32(clinical_document))
    end
    
    # Languages
    if self.languages 
      self.languages.each do |language|
        errors.concat(language.validate_c32(clinical_document))
      end
    end
 
    # Healthcare Providers
    if self.providers 
      self.providers.each do |provider|
        errors.concat(provider.validate_c32(clinical_document))
      end
    end

    # Insurance Providers
    if self.insurance_providers 
      self.insurance_providers.each do |insurance_providers|
        errors.concat(insurance_providers.validate_c32(clinical_document))
      end
    end

    # Medications
    if self.medications 
      self.medications.each do |medication|
        errors.concat(medication.validate_c32(clinical_document))
      end
    end

    # Supports
    if self.support
      errors.concat(self.support.validate_c32(clinical_document))
    end

    # Allergies
    if self.allergies
      self.allergies.each do |allergy|
        errors.concat(allergy.validate_c32(clinical_document))
      end
    end 
    
    # Conditions
    if self.conditions
      self.conditions.each do |condition|
        errors.concat(condition.validate_c32(clinical_document))
      end  
    end

    # Information Source
    if self.information_source
      # Need to pass in the root element otherwise the first XPath expression doesn't work
      errors.concat(self.information_source.validate_c32(clinical_document.root))
    end
    
    # Advance Directive
    if self.advance_directive
      errors.concat(self.advance_directive.validate_c32(clinical_document))
    end

    # Results
    if self.results
      self.results.each do |result|
        errors.concat(result.validate_c32(clinical_document))
      end
    end

    # Immunizations
    if self.immunizations
      self.immunizations.each do |immunization|
        errors.concat(immunization.validate_c32(clinical_document))
      end
    end

    # Encounters
    if self.encounters
      self.encounters.each do |encounter|
        errors.concat(encounter.validate_c32(clinical_document))
      end
    end

    # Removes all the nils... just in case.
    errors.compact!
    errors
  end

  def copy

    copied_patient_data = self.clone
    copied_patient_data.save!

    if self.registration_information
      copied_patient_data.registration_information = self.registration_information.copy
      # TODO: Copying the children on registration info should be moved into the RegistrationInformation class
      copied_patient_data.registration_information.race = self.registration_information.race
      copied_patient_data.registration_information.ethnicity = self.registration_information.ethnicity
      copied_patient_data.registration_information.marital_status = self.registration_information.marital_status
      copied_patient_data.registration_information.gender = self.registration_information.gender
      copied_patient_data.registration_information.religion = self.registration_information.religion
    end

    self.languages.each do |language|
      copied_language = language.clone
      copied_language.patient_data = copied_patient_data
      copied_language.save!
    end

    copied_patient_data.support = self.support.copy if self.support

    self.providers.each do |provider|
      copied_patient_data.providers << provider.copy
    end

    self.medications.each do |medication|
      copied_patient_data.medications << medication.clone
    end

    self.insurance_providers.each do |insurance_provider|

      cloned_insurance_provider = insurance_provider.clone

      cloned_insurance_provider.insurance_provider_patient = insurance_provider.insurance_provider_patient.clone
      cloned_insurance_provider.insurance_provider_patient.person_name = insurance_provider.insurance_provider_patient.person_name.clone
      cloned_insurance_provider.insurance_provider_patient.address = insurance_provider.insurance_provider_patient.address.clone
      cloned_insurance_provider.insurance_provider_patient.telecom = insurance_provider.insurance_provider_patient.telecom.clone

      cloned_insurance_provider.insurance_provider_subscriber = insurance_provider.insurance_provider_subscriber.clone
      cloned_insurance_provider.insurance_provider_subscriber.person_name  = insurance_provider.insurance_provider_subscriber.person_name.clone
      cloned_insurance_provider.insurance_provider_subscriber.address = insurance_provider.insurance_provider_subscriber.address.clone
      cloned_insurance_provider.insurance_provider_subscriber.telecom = insurance_provider.insurance_provider_subscriber.telecom.clone

      cloned_insurance_provider.insurance_provider_guarantor = insurance_provider.insurance_provider_guarantor.clone
      cloned_insurance_provider.insurance_provider_guarantor.person_name = insurance_provider.insurance_provider_guarantor.person_name.clone
      cloned_insurance_provider.insurance_provider_guarantor.address = insurance_provider.insurance_provider_guarantor.address.clone
      cloned_insurance_provider.insurance_provider_guarantor.telecom = insurance_provider.insurance_provider_guarantor.telecom.clone

      copied_patient_data.insurance_providers << cloned_insurance_provider
    end

    self.allergies.each do |allergy|
      copied_patient_data.allergies << allergy.clone
    end

    self.conditions.each do |condition|
      copied_patient_data.conditions << condition.clone
    end

    copied_patient_data.information_source = self.information_source.copy if self.information_source

    copied_patient_data.advance_directive = self.advance_directive.copy if self.advance_directive

    self.results.each do |result|
      copied_patient_data.results << result.clone
    end

    self.immunizations.each do |immunization|
      copied_patient_data.immunizations << immunization.clone
    end

    self.encounters.each do |encounter|
      copied_patient_data.encounters << encounter.copy
    end

    self.procedures.each do |procedure|
      copied_patient_data.procedures << procedure.clone
    end

    self.medical_equipments.each do |medical_equipment|
      copied_patient_data.medical_equipments << medical_equipment.clone
    end

    copied_patient_data
  end

  def to_c32(xml = Builder::XmlMarkup.new)

    xml.ClinicalDocument("xsi:schemaLocation" => "urn:hl7-org:v3 http://xreg2.nist.gov:8080/hitspValidation/schema/cdar2c32/infrastructure/cda/C32_CDA.xsd",
                         "xmlns" => "urn:hl7-org:v3",
                         "xmlns:sdtc" => "urn:hl7-org:sdtc",
                         "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance") do
      xml.typeId("root" => "2.16.840.1.113883.1.3",
                 "extension" => "POCD_HD000040")
      xml.templateId("root" => "2.16.840.1.113883.3.27.1776",
                     "assigningAuthorityName" => "CDA/R2")
      xml.templateId("root" => "2.16.840.1.113883.10.20.1", 
                     "assigningAuthorityName" => "CCD")
      xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.1", 
                     "assigningAuthorityName" => "HITSP/C32")
      xml.id("root" => "2.16.840.1.113883.3.72", 
             "extension" => "Laika C32 Test", 
             "assigningAuthorityName" => "Laika: An Open Source EHR Testing Framework projectlaika.org")
      xml.code("code" => "34133-9", 
               "displayName" => "Summarization of patient data", 
               "codeSystem" => "2.16.840.1.113883.6.1", 
               "codeSystemName" => "LOINC")
      xml.title(name)

      # FIXME Hard-coding EST time zone doesn't seem like a great idea...
      # TZ should either come from the environment or be an option set on deployment.
      if registration_information && registration_information.document_timestamp
        xml.effectiveTime("value" => registration_information.document_timestamp.strftime("%Y%m%d%H%M%S-0500"))
      else
        xml.effectiveTime("value" => updated_at.andand.strftime("%Y%m%d%H%M%S-0500"))
      end
      xml.confidentialityCode
      xml.languageCode("code" => "en-US")

      # Start Person (Registation) Information
      xml.recordTarget do
        xml.patientRole do
          registration_information.andand.to_c32(xml)
        end
      end
      # End Person (Registation) Information

      # Start Information Source
      information_source.andand.to_c32(xml)
      # End Information Source

      xml.custodian do
        xml.assignedCustodian do
          xml.representedCustodianOrganization do
            xml.id
          end
        end
      end

      # Start Guardian Support
      if support && support.contact_type && support.contact_type.code != "GUARD"
        support.to_c32(xml)
      end
      # End Guardian Support

      # Start Healthcare Providers
      providers.to_c32(xml)
      # End Healthcare Providers

      # Start CCD/C32 Modules
      xml.component do
        xml.structuredBody do
          
          pregnancy_c32(xml)

          # Start Conditions
          conditions.to_c32(xml)
          # End Conditions

          # Start Allergies
          allergies.to_c32(xml)
          # End Allergies

          # Start Insurance Providers
          insurance_providers.to_c32(xml)
          # End Insurance Providers

          medications.to_c32(xml)

          # Start Advanced Directive
          advance_directive.andand.to_c32(xml)
          # End Advanced Directive

          # Start Vital Signs
          unless vital_signs.empty?
            xml.component do
              xml.section do
                xml.templateId("root" => "2.16.840.1.113883.10.20.1.16", 
                               "assigningAuthorityName" => "CCD")
                xml.code("code" => "8716-3", 
                         "displayName" => "Vital signs", 
                         "codeSystem" => "2.16.840.1.113883.6.1", 
                         "codeSystemName" => "LOINC")
                xml.title("Vital signs")
                xml.text do
                  xml.table("border" => "1", "width" => "100%") do
                    xml.thead do
                      xml.tr do
                        xml.th "Vital Sign ID"
                        xml.th "Vital Sign Date"
                        xml.th "Vital Sign Display Name"
                        xml.th "Vital Sign Value"
                        xml.th "Vital Sign Unit"
                      end
                    end
                    xml.tbody do
                      vital_signs.each do |vital_sign|
                        xml.tr do 
                          xml.td do
                            xml.content(vital_sign.result_id, "ID" => "vital_sign-#{vital_sign.result_id}")
                          end
                          xml.td(vital_sign.result_date)
                          xml.td(vital_sign.result_code_display_name)
                          xml.td(vital_sign.value_scalar)
                          xml.td(vital_sign.value_unit)
                        end
                      end
                    end
                  end
                end

                # XML content inspection
                vital_signs.each do |vital_sign| 
                  vital_sign.to_c32(xml)
                end

              end
            end
          end
          # End Vital Signs

          # Start Results
          unless results_only.empty?
            xml.component do
              xml.section do
                xml.templateId("root" => "2.16.840.1.113883.10.20.1.14", 
                               "assigningAuthorityName" => "CCD")
                xml.code("code" => "30954-2", 
                         "displayName" => "Relevant diagnostic tests", 
                         "codeSystem" => "2.16.840.1.113883.6.1", 
                         "codeSystemName" => "LOINC")
                xml.title("Results")
                xml.text do
                  xml.table("border" => "1", "width" => "100%") do
                    xml.thead do
                      xml.tr do
                        xml.th "Result ID"
                        xml.th "Result Date"
                        xml.th "Result Display Name"
                        xml.th "Result Value"
                        xml.th "Result Unit"
                      end
                    end
                    xml.tbody do
                      results_only.each do |result|
                        xml.tr do 
                          xml.td do
                            xml.content(result.result_id, "ID" => "result-#{result.result_id}")
                          end
                          xml.td(result.result_date)
                          xml.td(result.result_code_display_name)
                          xml.td(result.value_scalar)
                          xml.td(result.value_unit)
                        end
                      end
                    end
                  end
                end

                # XML content inspection
                results_only.each do |result| 
                  result.to_c32(xml)
                end

              end
            end
          end
          # End Results

          immunizations.to_c32(xml)

          encounters.to_c32(xml)

          procedures.to_c32(xml)

          medical_equipments.to_c32(xml)
        end
      end
      # END CCD/C32 Modules
    end
  end

  def randomize()

    # need to ensure that the random name for registration is
    # the same name as this patient data
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    self.name = @first_name + " " +  @last_name

    @name = PersonName.new
    @name.first_name = @first_name
    @name.last_name = @last_name

    self.registration_information.randomize(@name)

    # if patient is female, 10% chance patient is pregnant
    if self.registration_information.gender.code == 'F'
      random_pregnant = rand(10) 
      if random_pregnant > 8
        self.pregnant = true 
      else
        self.pregnant = false
      end
    else
      self.pregnant = nil
    end 

    @provider = Provider.new
    @provider.randomize(self.registration_information)
    self.providers << @provider

    @insurance = InsuranceProvider.new
    @insurance.randomize(self.registration_information)
    self.insurance_providers << @insurance

    @allergy = Allergy.new
    @allergy.randomize(self.registration_information.date_of_birth)
    self.allergies << @allergy

    @condition = Condition.new
    @condition.randomize(self.registration_information.date_of_birth)
    self.conditions << @condition

    @language = Language.new
    @language.randomize()
    self.languages << @language

    @immunization = Immunization.new
    @immunization.randomize(self.registration_information.date_of_birth)
    self.immunizations << @immunization

    @medication = Medication.new
    @medication.randomize()
    self.medications << @medication

    self.support = Support.new
    self.support.randomize(self.registration_information.date_of_birth)
    
    self.information_source = InformationSource.new
    self.information_source.randomize()

    @result = Result.new
    @result.randomize()
    @result.type = 'Result'
    self.results << @result

    @vital_sign = VitalSign.new
    @vital_sign.randomize()
    self.results << @vital_sign

    self.advance_directive = AdvanceDirective.new
    self.advance_directive.randomize(self.registration_information.date_of_birth)

    @encounter = Encounter.new
    @encounter.randomize(self.registration_information.date_of_birth)
    self.encounters << @encounter

    @procedure = Procedure.new
    @procedure.randomize(self.registration_information.date_of_birth)
    self.procedures << @procedure

    @medical_equipment = MedicalEquipment.new
    @medical_equipment.randomize(self.registration_information.date_of_birth)
    self.medical_equipments << @medical_equipment

  end

 private

  # If the patient is pregnant, this method will add the appropriate
  # C32 component to the provided XML::Builder object.
  def pregnancy_c32(xml)
    if pregnant
      xml.component do
        xml.section do
          xml.title "Results"
          xml.text "Patient is currently pregnant"
          xml.entry do
            xml.observation("classCode" => "OBS", "moodCode" => "EVN") do
              # why is code here you ask, because the schema states it needs to be 
              # event though the C32 doc does not include it, one more reason to just
              # hate the CDA/CCD/C32 specs
              xml.code("code" => "77386006",
                       "displayName" => "Patient currently pregnant",
                       "codeSystem" => "2.16.840.1.113883.6.96",
                       "codeSystemName" => "SNOMED CT")
              xml.value("xsi:type" => "CD",
                        "code" => "77386006",
                        "displayName" => "Patient currently pregnant",
                        "codeSystem" => "2.16.840.1.113883.6.96",
                        "codeSystemName" => "SNOMED CT")
            end
          end
        end
      end
    end
  end
end
