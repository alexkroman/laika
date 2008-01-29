class RegistrationInformation < ActiveRecord::Base
  belongs_to :patient_data
  has_one :person_name, :as => :nameable
  
  def copy
    copied_registration_information = self.clone
    copied_registration_information.save!
    copied_person_name = self.person_name.clone
    copied_registration_information.person_name = copied_person_name
    
    copied_registration_information
  end
end
