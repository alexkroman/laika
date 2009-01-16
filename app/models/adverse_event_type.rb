class AdverseEventType < ActiveRecord::Base
  has_select_options
      
    
    def to_c32(xml)
        
        xml.code("code"=>code)
    end
    
end
