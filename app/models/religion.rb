class Religion < ActiveRecord::Base
  named_scope :all, :order => 'name ASC'

  def to_c32(xml)
    xml.religiousAffiliationCode("code" => code, 
                                 "displayName" => name, 
                                 "codeSystemName" => "Religious Affiliation", 
                                 "codeSystem" => "2.16.840.1.113883.5.1076")        
  end

end
