class MaritalStatus < ActiveRecord::Base
  named_scope :all, :order => 'name ASC'

 def to_c32(xml)
        xml.maritalStatusCode("code" => code, 
                              "displayName" => name, 
                              "codeSystemName" => "MaritalStatusCode", 
                              "codeSystem" => "2.16.840.1.113883.5.2")
    end
    
end
