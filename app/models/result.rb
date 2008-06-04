class Result < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :code_system
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
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
          xml.statusCode("code" => self.status_code)
        end
        if self.result_date
          xml.effectiveTime("value" => self.result_date.to_formatted_s(:hl7_ts))
        end
        xml.value("xsi:type" => "PQ", "value" => self.value_scalar, "unit" => self.value_unit)
      end
    end
  end
  
  def validate_c32(document)
    errors = []
    errors << safe_match(document) do 
      errors << match_required(document,
                                "//cda:section[./cda:templateId[@root = '2.16.840.1.113883.10.20.1.14']]",
                                @@default_namespaces,
                                {},
                                nil,
                                "C32 Result section with templateId 2.16.840.1.113883.10.20.1.14 not found",
                                document.xpath) do |section|
        errors << match_required(section,
                                 "./cda:entry/cda:observation[cda:id/@root = $id]",
                                @@default_namespaces,
                                {"id" => self.result_id},
                                nil,
                                "Result with #{self.result_id} not found",
                                section.xpath) do |result_element|
          errors << match_required(result_element,
                                    "./cda:code",
                                    @@default_namespaces,
                                    {},
                                    nil,
                                    "Required code element not found",
                                    result_element.xpath) do |code_element|
            errors << match_value(code_element, "@code", "result_code", self.result_code)
            errors << match_value(code_element, "@displayName", "result_code_display_name", self.result_code_display_name)
            errors << match_value(code_element, "@codeSystem", "code_system", self.code_system.andand.code)
            errors << match_value(code_element, "@codeSystemName", "code_system_name", self.code_system.andand.name)
          end
          errors << match_value(result_element, "cda:statusCode/@code", "status_code", self.status_code)
          errors << match_value(result_element, "cda:effectiveTime/@value", "result_date", self.result_date.andand.to_formatted_s(:hl7_ts))
          errors << match_value(result_element, "cda:value/@value", "value_scalar", self.value_scalar)
          errors << match_value(result_element, "cda:value/@unit", "value_unit", self.value_unit)
        end
      end
    end
    errors.compact
  end
end
