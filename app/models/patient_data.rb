class PatientData < ActiveRecord::Base
  has_one :registration_information
  has_many :languages
  has_many :providers
  has_one :support
  belongs_to :vendor_test_plan
  
  def copy
    copied_patient_data = self.clone
    copied_patient_data.save!
    copied_patient_data.registration_information = self.registration_information.copy if self.registration_information

    self.languages.each do |language|
      copied_language = language.clone
      copied_language.patient_data = copied_patient_data
      copied_language.save!
    end
    
    copied_patient_data.support = self.support.copy if self.support
    
    self.providers.each do |provider|
      copied_patient_data.providers << provider.copy
    end
    
    copied_patient_data
  end
end
