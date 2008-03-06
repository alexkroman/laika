class AdvanceDirective < ActiveRecord::Base  
  strip_attributes!
    
  belongs_to :patient_data  
  belongs_to :advance_directive_type
  include PersonLike
  
end
