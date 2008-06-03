class Result < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :code_system
  
  def to_c32(xml)
    xml.entry do
      xml.observation("classCode" => "OBS", "moodCode" => "EVN") do
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.31", "assigningAuthorityName" => "CCD")
        xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.16", "assigningAuthorityName" => "HITSP/C32")
        if self.result_id
          xml.id("root" => self.result_id)
        end
        if self.result_code
          xml.code("code" => self.result_code, "displayName" => self.result_code_display_name,
                   "codeSystem" => self.code_system.andand.code,
                   "codeSystemName" => self.code_system.andand.name)
        end
        if self.status_code
          xml.statusCode("value" => self.status_code)
        end
        if self.result_date
          xml.effectiveTime do
            xml.low("value" => self.result_date.to_formatted_s(:hl7_ts))
          end
        end
        xml.value("xsi:type" => "PQ", "value" => self.value_scalar, "unit" => self.value_unit)
      end
    end
  end
end
