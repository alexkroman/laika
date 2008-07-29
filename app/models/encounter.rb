class Encounter < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :encounter_location_code
  
  include PersonLike
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"} 
  
  #Reimplementing from MatchHelper
  def section_name
    "Encounters Module"
  end
  
  def validate_c32(document)
    errors=[]  
    errors.compact
  end
  
  def to_c32(xml)    
  	xml.entry('typeCode'=>'DRIV') {     
      xml.encounter('classCode'=>'ENC', 'moodCode'=>'EVN') { 
        xml.templateId('root' => '2.16.840.1.113883.10.20.1.21', 
                       'assigningAuthorityName' => 'CCD')
        xml.templateId('root' => '2.16.840.1.113883.3.88.11.32.17',
                       'assigningAuthorityName' => 'HITSP/C32') 
        xml.id ('root' => encounter_id)
        if encounter_date != nil 
          xml.effectiveTime {
            xml.low('value'=> encounter_date.strftime('%Y%m%d'))
          }
        end
        xml.participant('typeCode'=>'PRF') {
          xml.participantRole('classCode' => 'PROV') {        
            address.andand.to_c32(xml)
            telecom.andand.to_c32(xml)  
            xml.playingEntity do
              person_name.andand.to_c32(xml)
            end
          }
        }
      }
    }
  end
  
  def randomize(birth_date)
    @possible_procedures = ['Heart Valve', 'IUD', 'Artificial Hip', 'Bypass', 'Hypothermia']
    @descriptions = ['Heart Valve Replacement', 'Insertion of intrauterine device (IUD)', 'Hip replacement surgery', 'Bypass surgery', 'Treatement for hypothermia']
    @index = rand(5)

    self.encounter_date = DateTime.new(birth_date.year + rand(DateTime.now.year - birth_date.year), rand(12) + 1, rand(28) +1)
    self.person_name = PersonName.new
    self.person_name.name_prefix = 'Dr.'
    self.person_name.first_name = Faker::Name.first_name
    self.person_name.last_name = Faker::Name.last_name
    self.address = Address.new
    self.address.randomize()
    self.telecom = Telecom.new
    self.telecom.randomize()
    self.code = (10000 + rand(89999)).to_s
    self.free_text = @possible_procedures[@index]
    self.name = @descriptions[@index]
  end
  
end