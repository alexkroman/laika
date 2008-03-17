class Ethnicity < ActiveRecord::Base

def to_c32(xml)
    xml.ethnicityCode("code" => code, 
                      "displayName" => name, 
                      "codeSystemName" => "CDC Race and Ethnicity", 
                      "codeSystem" => "2.16.840.1.113883.6.238")    
end

end
