class MedicalEquipment < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  
  include MatchHelper

  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}

  #Reimplementing from MatchHelper
  def section_name
    "Medical Equipment Module"
  end

  def validate_c32(document)
    
  end

  def to_c32(xml)

    xml.entry("typeCode" => "DRIV") do
      xml.supply("classCode" => "SPLY", "moodCode" => "EVN") do
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.34")
        if supply_id
          xml.id("root" => supply_id)
        end
        xml.statusCode("code" => "completed")
        if date_supplied
          xml.effectiveTime("xsi:type"=>"IVL_TS") do 
            xml.center("value" => date_supplied.strftime("%Y%m%d"))
          end
        end
        xml.participant("typeCode" => "DEV") do
          xml.participantRole("classCode" => "MANU") do
            xml.templateId("root" => "2.16.840.1.113883.10.20.1.52")
            if name && code
              xml.playingDevice do
                xml.code("code" => code,
                         "codeSystem" => "2.16.840.1.113883.6.96",
                         "displayName" => name)
              end
            end
          end
        end
      end
    end
  end

  def randomize(birth_date)
    # TODO: need to have a pool of potential medical equipments in the database
    self.name = "Automatic implantable cardioverter defibrillator"
    self.code = "72506001"
    self.encounter_date = DateTime.new(birth_date.year + rand(DateTime.now.year - birth_date.year), rand(12) + 1, rand(28) +1)
  end
  
end