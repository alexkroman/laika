class Procedure < ActiveRecord::Base
  strip_attributes!
  
  belongs_to :patient_data
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  #Reimplementing from MatchHelper
  def section_name
    "Procedures Module"
  end
  
  def validate_c32(document)
    
  end
  
  def to_c32(xml)
    xml.entry("typeCode" => "DRIV") do
      xml.procedure("classCode" => "PROC", 
                    "moodCode" => "EVN") do
        xml.templateID("root" => "2.16.840.1.113883.10.20.1.29")
        if self.procedure_id
          xml.id("root" => self.procedure_id)
        end
        if self.code
          xml.code("code" => self.code) do 
            xml.originalText do
              xml.reference("value" => "Proc-"+self.id.to_s)
            end
          end
        end
        xml.statusCode("code" => "completed")
        if self.procedure_date
          xml.effectiveTime("value" => procedure_date.strftime("%Y"))
        end 
      end
    end 
  end
  
  def randomize(birth_date)
    # TODO: need to have a pool of potential procdures in the database
    self.name = "Total hip replacement, left"
    self.id = "e401f340-7be2-11db-9fe1-0800200c9a66"
    self.code = "52734007"
    self.procedure_date = DateTime.new(birth_date.year + rand(DateTime.now.year - birth_date.year), rand(12) + 1, rand(28) +1)
  end
  
end
