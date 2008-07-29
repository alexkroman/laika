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
    
  end
  
  def randomize()
    # TODO: need to have a pool of potential medical equipments in the database
    self.name = "Automatic implantable cardioverter defibrillator"
    self.code = "72506001"
  end
  
end