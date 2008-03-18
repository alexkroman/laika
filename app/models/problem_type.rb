class ProblemType < ActiveRecord::Base

  include MatchHelper
    
  def validate_c32(code)
  
    unless code
      return [ContentError.new]
    end
    
    errors = []
    errors << match_value(code,'@code','code',code)
    errors << match_value(code,'@displayName','displayName',name)
    return errors.compact
    
  end 
      
end
