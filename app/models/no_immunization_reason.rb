class NoImmunizationReason < ActiveRecord::Base

  def to_c32(xml)
    xml.entryRelationship('typeCode' => 'RSON') {
      xml.act('classCode' => 'ACT', 'moodCode' => 'EVN') {
        xml.templateId('root' => '2.16.840.1.113883.10.20.1.27')
        xml.code('code' => code, 'codeSystem' => '2.16.840.1.113883.6.96', 'displayName'=>'name')
      }
    }
  end

end