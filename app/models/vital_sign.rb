# This class represents the vital sign section of a C32 Document
# Since the vital signs are exactly the same as results, the same
# database structure is used (via ActiveRecord's STI facilities)
#
# Methods in this class are overides to provide different template
# ids when validating and generating XML
class VitalSign < AbstractResult

  def section_template_id
    '2.16.840.1.113883.10.20.1.16'
  end

  def statement_c32_template_id
    '2.16.840.1.113883.3.88.11.32.15'
  end

  def self.c32_component(vital_signs, xml)
    # Start Vital Signs
    unless vital_signs.empty?
      xml.component do
        xml.section do
          xml.templateId("root" => "2.16.840.1.113883.10.20.1.16", 
                         "assigningAuthorityName" => "CCD")
          xml.code("code" => "8716-3", 
                   "displayName" => "Vital signs", 
                   "codeSystem" => "2.16.840.1.113883.6.1", 
                   "codeSystemName" => "LOINC")
          xml.title("Vital signs")
          xml.text do
            xml.table("border" => "1", "width" => "100%") do
              xml.thead do
                xml.tr do
                  xml.th "Vital Sign ID"
                  xml.th "Vital Sign Date"
                  xml.th "Vital Sign Display Name"
                  xml.th "Vital Sign Value"
                  xml.th "Vital Sign Unit"
                end
              end
              xml.tbody do
                vital_signs.each do |vital_sign|
                  xml.tr do 
                    xml.td do
                      xml.content(vital_sign.result_id, "ID" => "vital_sign-#{vital_sign.result_id}")
                    end
                    xml.td(vital_sign.result_date)
                    xml.td(vital_sign.result_code_display_name)
                    xml.td(vital_sign.value_scalar)
                    xml.td(vital_sign.value_unit)
                  end
                end
              end
            end
          end

          yield

        end
      end
    end
    # End Vital Signs
  end
end
