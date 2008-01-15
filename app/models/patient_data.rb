class PatientData < ActiveRecord::Base
  has_one :registration_information
  has_many :languages
  belongs_to :vendor_test_plan
end
