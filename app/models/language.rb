# HL7 LanguageAbilityMode
# ESGN  Expressed signed    
# ESP   Expressed spoken  
# EWR   Expressed written   
# RSGN  Received signed   
# RSP   Received spoken   
# RWR   Received written

class Language < ActiveRecord::Base
  belongs_to :patient_data
end
