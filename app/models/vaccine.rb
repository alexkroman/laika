class Vaccine < ActiveRecord::Base

  def to_c32(xml)
    xml.code('code' => code, 
             'codeSystem' => '2.16.840.1.113883.6.59',
             'displayName' => name) {
      xml.originalText name	
    }
  end
  
end