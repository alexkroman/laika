class EncounterType < ActiveRecord::Base
  
  include MatchHelper
    
  def validate_c32(encounter_type)
  
    unless encounter_type
      return [ContentError.new]
    end
    
    errors = []
    
    return errors.compact
    
  end
  
end