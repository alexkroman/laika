class AdverseEventType < ActiveRecord::Base
  named_scope :all, :order => 'name ASC'
      
    
    def to_c32(xml)
        
        xml.code("code"=>code)
    end
    
end
