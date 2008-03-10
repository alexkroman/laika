class InformationSource < ActiveRecord::Base  
  strip_attributes!
    
  belongs_to :patient_data  
  include PersonLike
  include MatchHelper
  
  def validate_c32(parent)
     errors = []
     author = REXML::XPath.first(parent,"ancestor-or-self::/cda:author[1]", {'cda' => 'urn:hl7-org:v3'})
     if(author )
         ## TO-DO  MATCH TIME ELEMENTS    Required /Non Repeat      cda:time
       assignedPerson = REXML::XPath.first(author,"./cda:assignedAuthor/cda:assignedPerson/cda:name", {'cda' => 'urn:hl7-org:v3'})
       errors.concat self.person_name.validate_c32(assignedPerson)
       
       
     else
         errors << ContentError.new(:section=>"InformationSource",:error_message=>"Author not found",:location=>(parent)? parent.xpath : '')
     end
     
     return errors.compact
  end
  
  
  def section
      "InformationSource"
  end
  
  
  
end


