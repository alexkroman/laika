class Medication < ActiveRecord::Base
  belongs_to :patient_data
end
