class Result < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :code_system
  belongs_to :result_type_code
  belongs_to :act_status_code
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def section_template_id
    '2.16.840.1.113883.10.20.1.14'
  end
  
  def statement_ccd_template_id
    '2.16.840.1.113883.10.20.1.31'
  end
  
  def statement_c32_template_id
    '2.16.840.1.113883.3.88.11.32.16'
  end
  
  #Reimplementing from MatchHelper
  def section_name
    "Results Module"
  end
  
  def to_c32(xml)
    xml.entry do
      xml.observation("classCode" => "OBS", "moodCode" => "EVN") do
        xml.templateId("root" => statement_ccd_template_id, "assigningAuthorityName" => "CCD")
        xml.templateId("root" => statement_c32_template_id, "assigningAuthorityName" => "HITSP/C32")
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
                                "//cda:section[./cda:templateId[@root = '#{section_template_id}']]",
                                @@default_namespaces,
                                {},
                                nil,
                                "C32 Result section with templateId #{section_template_id} not found",
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
  
  def randomize()
    
    self.result_id = rand(100).to_s + 'd' + rand(100000).to_s + '-bd' + rand(100).to_s + '-4c90-891d-eb716d' + rand(10000).to_s + 'c4'
    self.result_date = DateTime.new(2000 + rand(9), rand(12) + 1, rand(28) + 1)
    self.code_system = CodeSystem.find 143755023 # sets code system as LOINC
    self.status_code = 'N'
    self.value_scalar = (100 + rand(100)).to_s
    
    if (rand < 0.5)
      self.value_unit = 'lbs'
      self.result_code_display_name = 'Body Weight'
      self.result_code = '3141-9'
    else
      self.value_unit = 'mg/dL'
      self.result_code_display_name = 'Cholesterol'
      self.result_code = '2093-3'
    end
    
    # Only create organizer data 1/2 the time
    if (rand < 0.5)
      organizer_id = "33d07056-bd27-4c90-891d-eb716d3170c4"
      result_type_code = ResultTypeCode.find(:all).sort_by {rand}.first
      act_status_code = ActStatusCode.find(:all).sort_by {rand}.first
    end
    
  end
  
end
