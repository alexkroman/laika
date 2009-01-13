class AdvanceDirectiveType < ActiveRecord::Base  
  named_scope :all, :order => 'name ASC'

    include MatchHelper
    
    def validate_c32(type)
        
        unless type
            return [ContentError.new]
        end
        
        errors = []
        errors << match_value(type,'@code','code',code)
        errors << match_value(type,'@displayName','displayName',name)
        return errors.compact
    end 
  
  
end
