class InformationSource < ActiveRecord::Base  
  strip_attributes!
    
  belongs_to :patient_data  
  
  include PersonLike
  include MatchHelper
  
  #Reimplementing from MatchHelper
  def section_name
    "Information Source Module"
  end
  
  def validate_c32(document)
    errors = []
    begin      
      author = REXML::XPath.first(document,"ancestor-or-self::/cda:author[1]", {'cda' => 'urn:hl7-org:v3'})
      if(author)
        ## TO-DO MATCH TIME ELEMENTS Required / Non Repeat cda:time
        assignedPerson = REXML::XPath.first(author,"./cda:assignedAuthor/cda:assignedPerson/cda:name", {'cda' => 'urn:hl7-org:v3'})
        errors.concat self.person_name.validate_c32(assignedPerson)
      else
        errors << ContentError.new(:section=>"InformationSource",
                                   :error_message=>"Author not found",
                                   :location=>(document)? document.xpath : '')
      end
    rescue
      errors << ContentError.new(:section => 'InformationSource', 
                                 :error_message => 'Invalid, non-parsable XML for information source data',
                                 :type=>'error',
                                 :location => document.xpath)
    end
    errors.compact
  end
  
  
  def section
    "InformationSource"
  end
  
  def to_c32(xml)
    xml.author {
      if self.time
        xml.time("value"=>time.strftime("%Y%m%d"))
      end 
      xml.assignedAuthor {
        xml.id("root"=>document_id)
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
              xml.family(person_name.last_name, "qualifier" => "BR")
            end
            if person_name.name_suffix &&
               person_name.name_suffix.size > 0
              xml.prefix person_name.name_suffix
            end
          }
        }
        xml.representedOrganization {
          xml.id("root" => "2.16.840.1.113883.19.5") 
          xml.name organization_name
        }
      }
    }      
  end
  
  def randomize()
    chars = ('A'..'Z').to_a
    char = chars[rand(chars.length)]
    self.time =  DateTime.new(2000 + rand(9), rand(12) + 1, rand(28) + 1)
    self.person_name = PersonName.new
    self.person_name.first_name = Faker::Name.first_name
    self.person_name.last_name = Faker::Name.last_name
    self.document_id = 'ABC-1234567-' + char + char
  end
  
end


