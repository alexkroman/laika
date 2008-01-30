class Support < ActiveRecord::Base
  belongs_to :patient_data
  include PersonLike
end
