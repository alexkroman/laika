class PatientData < ActiveRecord::Base
  has_one    :registration_information
  has_many   :languages
  has_many   :providers
  has_many   :medications
  has_one    :support
  has_many   :allergies
  has_one    :information_source
  has_one    :advance_directive
  has_many   :comments
  belongs_to :vendor_test_plan
  belongs_to :user
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def validate_c32(clinical_document)
    errors = self.registration_information.validate_c32(clinical_document)
    errors
  end
  
  def copy
    copied_patient_data = self.clone
    copied_patient_data.save!
    
    if self.registration_information
      copied_patient_data.registration_information = self.registration_information.copy
      # TODO: Copying the children on registartion info should be moved into the RegistrationInformation class
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
    
    self.allergies.each do |allergy|
      copied_patient_data.allergies << allergy.clone
    end
    
    copied_patient_data.information_source = self.information_source.copy if self.information_source
    
    self.comments.each do |comment|
      copied_patient_data.comments << comment.copy
    end
    
    copied_patient_data.advance_directive = self.advance_directive.copy if self.advance_directive
    
    copied_patient_data
  end
end
