class RegistrationInformation < ActiveRecord::Base
  belongs_to :patient_data
  has_one :person_name, :as => :nameable
  has_one :address, :as => :addressable
  has_one :telecom, :as => :reachable
  
  def copy
    copied_registration_information = self.clone
    copied_registration_information.save!
    copied_registration_information.person_name = self.person_name.clone
    copied_registration_information.address = self.address.clone
    copied_registration_information.telecom = self.telecom.clone
    
    copied_registration_information
  end
end
