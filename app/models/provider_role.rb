class ProviderRole < ActiveRecord::Base
      
   include MatchHelper
    
   def validate_c32(role )
       unless role
           return [ContentError.new]
       end
       
       errors = []
         
       return errors.compact
   end
   
end
