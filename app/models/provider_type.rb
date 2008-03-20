class ProviderType < ActiveRecord::Base
      
    include MatchHelper
     
    def validate_c32(type)
        
        unless type
          return [ContentError.new(:section => 'Provider', :subsection => 'ProviderType',
                                   :error_message => 'Unable to find provider type')]
        end
        
        errors = []
        errors << match_value(type,'@code','code',code)
        errors << match_value(type,'@displayName','displayName',name)
        return errors.compact
    end
    
    def to_c32(xml)
      xml.code("code" => code,
               "displayName" => name,
               "codeSystem" => "2.16.840.1.113883.6.101",
               "codeSystemName" => 'ProviderCodes')
    end
end
