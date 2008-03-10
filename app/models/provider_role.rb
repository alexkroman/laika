class ProviderRole < ActiveRecord::Base
      
   include MatchHelper
    
   def validate_c32(role )
       unless role
           return [ContentError.new]
       end
       
       errors = []
       errors << match_value(role,'@code','code',code)
       errors << match_value(role,'@displayName','displayName',name)
       return errors.compact
   end
   
end
