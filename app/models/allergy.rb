class Allergy < ActiveRecord::Base
  belongs_to :patient_data
  belongs_to :adverse_event_type
  belongs_to :severity_term
end
