class Vaccine < ActiveRecord::Base

  #Reimplementing from MatchHelper
  def section_name
    "Vaccines Module"
  end

  def to_c32(xml)
    xml.code('code' => code, 
             'codeSystem' => '2.16.840.1.113883.6.59',
             'displayName' => name) do
      xml.originalText name	
    end
  end

end