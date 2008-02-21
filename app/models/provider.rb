class Provider < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :provider_type
  belongs_to :provider_role
  
  include PersonLike
end
