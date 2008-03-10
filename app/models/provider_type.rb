class ProviderType < ActiveRecord::Base
      
    include MatchHelper
     
    def validate_c32(type)
        
        unless type
            return [ContentError.new]
        end
        
        errors = []
        
        return errors.compact
    end 
end
