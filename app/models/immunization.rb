class Immunization < ActiveRecord::Base
  strip_attributes!

  belongs_to :vaccine
  belongs_to :no_immunization_reason
  belongs_to :patient_data
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"} 
  
  def validate_c32(document)
    errors=[]  
    errors.compact
  end
  
  #Reimplementing from MatchHelper
  def section_name
    "Immunizations Module"
  end
  
  def to_c32(xml)    
    xml.entry('typeCode'=>'DRIV') do
      xml.substanceAdministration('classCode' => 'SBADM', 'moodCode' => 'EVN', 'negationInd' => refusal) do
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.24", "assigningAuthorityName" => "CCD")
        xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.14", "assigningAuthorityName" => "HITSP/C32")
        xml.id('root'=>'41755f58-d7c0-4aab-9f7c-a3a5d8df4581')
        xml.statusCode('code' => 'completed')
        if administration_date
          xml.effectiveTime('xsi:type' => "IVL_TS") do
            xml.center('value' => administration_date.strftime("%Y%m%d")) 
          end
        end
        xml.consumable do
          xml.manufacturedProduct do
            xml.templateId('root' => '2.16.840.1.113883.10.20.1.53')
            xml.manufacturedMaterial do
              if vaccine
                vaccine.andand.to_c32(xml)
              end 
              xml.lotNumberText(lot_number_text)
            end
          end
        end
        if no_immunization_reason
          no_immunization_reason.andand.to_c32(xml)
        end 
      end
    end
  end
  
  def randomize(birth_date)
    self.administration_date = DateTime.new(birth_date.year + rand(DateTime.now.year - birth_date.year), rand(12) + 1, rand(28) + 1)
    self.lot_number_text = "mm345-417-DFF"
    self.vaccine = Vaccine.find(:all).sort_by() {rand}.first
    if (rand > 0.5)
      self.refusal = true
      self.no_immunization_reason = NoImmunizationReason.find(:all).sort_by() {rand}.first
    else
      self.refusal = false
    end
  end
  
end