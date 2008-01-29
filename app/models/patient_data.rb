class PatientData < ActiveRecord::Base
  has_one :registration_information
  has_many :languages
  belongs_to :vendor_test_plan
  
  def copy
    copied_patient_data = self.clone
    copied_patient_data.save!
    copied_registration_information = self.registration_information.copy
    copied_registration_information.patient_data = copied_patient_data
    copied_registration_information.save!
    self.languages.each do |language|
      copied_language = language.clone
      copied_language.patient_data = copied_patient_data
      copied_language.save!
    end
    
    copied_patient_data
  end
end
