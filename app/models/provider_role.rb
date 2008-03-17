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
   
   
   def to_c32(xml, free_text=nil)
       xml.functionCode("code" => code,
                       "displayName" => name,
                       "codeSystem" => "2.16.840.1.113883.12.443", 
                       "codeSystemName" => "Provider Role") {
        if !free_text.blank?
             xml.originalText free_text
          end
    }       
   end
   
end
