class Support < ActiveRecord::Base
  belongs_to :patient_data
  belongs_to :contact_type
  belongs_to :relationship
  include PersonLike
end
