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
  
  def to_c32(xml)
      xml.author {
          xml.time time.strftime("%Y%m%d")
          xml.assignedAuthor {
            xml.id document_id
            xml.assignedPerson {
              xml.name {
                if person_name.name_prefix &&
                   person_name.name_prefix.size > 0
                  xml.prefix person_name.name_prefix
                end
                if person_name.first_name &&
                   person_name.first_name.size > 0
                  xml.given(person_name.first_name, "qualifier" => "CL")
                end
                if person_name.last_name &&
                   person_name.last_name.size > 0
                  xml.family (person_name.last_name, "qualifier" => "BR")
                end
                if person_name.name_suffix &&
                   person_name.name_suffix.size > 0
                  xml.prefix person_name.name_suffix
                end
              }
            }
            xml.representedOrganization {
              xml.id ("root" => "2.16.840.1.113883.19.5") 
              xml.name organization_name
            }
          }
        }      
  end
end


