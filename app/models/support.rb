class Support < ActiveRecord::Base
  belongs_to :patient_data
  belongs_to :contact_type
  include PersonLike
end
