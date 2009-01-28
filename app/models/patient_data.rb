class PatientData < ActiveRecord::Base
  has_c32_component :languages
  has_c32_component :providers
  has_c32_component :medications
  has_c32_component :allergies
  has_c32_component :insurance_providers
  has_c32_component :conditions
  has_c32_component :vital_signs
  has_c32_component :results
  has_c32_component :immunizations
  has_c32_component :encounters
  has_c32_component :procedures
  has_c32_component :medical_equipments

  has_one    :registration_information, :dependent => :destroy
  has_one    :support, :dependent => :destroy
  has_one    :information_source, :dependent => :destroy
  has_one    :advance_directive, :dependent => :destroy
  has_many   :all_results, :class_name => 'AbstractResult'

  belongs_to :vendor_test_plan
  belongs_to :user

  validates_presence_of :name

  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}

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
    if self.all_results
      self.all_results.each do |result|
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

    self.all_results.each do |result|
      copied_patient_data.all_results << result.clone
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

      information_source.andand.to_c32(xml)

      xml.custodian do
        xml.assignedCustodian do
          xml.representedCustodianOrganization do
            xml.id
          end
        end
      end

      if support && support.contact_type && support.contact_type.code != "GUARD"
        support.to_c32(xml)
      end

      providers.to_c32(xml)

      # Start CCD/C32 Modules
      xml.component do
        xml.structuredBody do
          
          pregnancy_c32(xml)

          conditions.to_c32(xml)

          allergies.to_c32(xml)

          insurance_providers.to_c32(xml)

          medications.to_c32(xml)

          advance_directive.andand.to_c32(xml)

          vital_signs.to_c32(xml)

          results.to_c32(xml)

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
    self.results << @result

    @vital_sign = VitalSign.new
    @vital_sign.randomize()
    self.vital_signs << @vital_sign

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
