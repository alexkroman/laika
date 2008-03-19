class AdverseEventType < ActiveRecord::Base
      
    
    def to_c32(xml)
        
        xml.code("code"=>code)
    end
    
end
