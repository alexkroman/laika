class Religion < ActiveRecord::Base

  def to_c32(xml)
    xml.religiousAffiliationCode("code" => code, 
                                 "displayName" => name, 
                                 "codeSystemName" => "Religious Affiliation", 
                                 "codeSystem" => "2.16.840.1.113883.5.1076")        
  end

end
