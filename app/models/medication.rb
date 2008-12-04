class Medication < ActiveRecord::Base

  strip_attributes!

  belongs_to :patient_data
  belongs_to :medication_type
  belongs_to :code_system
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def requirements
    {
      :product_coded_display_name => :hitsp_required,
      :product_code => :hitsp_r2_required,
      :code_system_id => :hitsp_r2_required,
      :medication_type_id => :hitsp_r2_required,
      :free_text_brand_name => :hitsp_r2_required,
      :status => :hitsp_r2_optional,
      :quantity_ordered_value => :hitsp_r2_optional,
      :quantity_ordered_unit => :hitsp_r2_optional,
      :expiration_date => :hitsp_r2_optional,
    }
  end

  #Reimplementing from MatchHelper
  def section_name
    "Medications Module"
  end
  
  def validate_c32(document)
    errors=[]
    errors << safe_match(document) do 
      errors << match_required(document,
                                "//cda:section[./cda:templateId[@root = '2.16.840.1.113883.10.20.1.8']]",
                                @@default_namespaces,
                                {},
                                nil,
                                "C32 Medication section with templateId 2.16.840.1.113883.10.20.1.8 not found",
                                document.xpath) do |section|
        # IF there is an entry for this medication then there will be a substanceAdministration element
        # that contains a consumable that contains a manufacturedProduct that has a code with the original text 
        # equal to the name of the generic medication
        # the consumeable/manfucaturedProduct/code/originalText is a required field if the substanceAdministration entry is there
        errors << match_required(section,
                                "./cda:entry/cda:substanceAdministration[ ./cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/cda:originalText/text() = $original]",
                                @@default_namespaces,
                                {"original"=>product_coded_display_name},
                                "substanceAdministration",
                                "A substanceAdministration section does not exist for the medication",
                                 section.xpath) do |substance_administration|
        
          #consumable product and assorted sub elements
          consumable = REXML::XPath.first(substance_administration,"./cda:consumable",@@default_namespaces)
        
          errors << content_required(consumable,"consumable","A consumable entry does not exist",substance_administration.xpath) do |consumable|
            manufactured = REXML::XPath.first(consumable,"./cda:manufacturedProduct",@@default_namespaces)
            code = REXML::XPath.first(manufactured,"./cda:manufacturedMaterial/cda:code",@@default_namespaces)
            translation = REXML::XPath.first(code,"cda:translation",@@default_namespaces)
            
            # test for the manufactured content
            errors << content_required(manufactured,"manufacturedMaterial","A manufacturedProduct entry does not exist",consumable) do 
              errors << match_value(manufactured, "cda:manufacturedMaterial/cda:name/text()", 'free_text_brand_name', free_text_brand_name)
            end
          end
          
          # validate the medication type Perscription or over the counter
          errors << match_value(substance_administration, 
                               "cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.3.88.11.32.10']/cda:code/@displayName",
                               'medication_type', 
                               medication_type.name)
          # validate the status
          errors << match_value(substance_administration,
                               "cda:entryRelationship[@typeCode='REFR']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.47']/cda:value/@code", 
                               'status', 
                               status)
        
          # validate the order quantity
          if order = REXML::XPath.first(substance_administration,
                                        "cda:entryRelationship[@typeCode='REFR']/cda:supply[@moodCode='INT']", 
                                        @@default_namespaces)
            errors << match_value(order, "cda:quantity/@value", "quantity_ordered_value", quantity_ordered_value)
            # This differs from the XPath expression given in the C32 spec which claims that the value should be under cda:high
            # however, the CCD schema claims that it should be an effectiveTime with no children
            errors << match_value(order, "cda:effectiveTime/@value", "expiration_time", expiration_time.andand.to_formatted_s(:hl7_ts))
          end
        end
      end
    end
    errors.compact
  end
  
  def to_c32(xml)
    xml.entry {
      xml.substanceAdministration("classCode" => "SBADM", "moodCode" => "EVN") {
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.24", "assigningAuthorityName" => "CCD")
        xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.8", "assigningAuthorityName" => "HITSP/C32")
        xml.id
        xml.consumable {        
          xml.manufacturedProduct("classCode" => "MANU") {
            xml.templateId("root" => "2.16.840.1.113883.10.20.1.53", "assigningAuthorityName" => "CCD") 
            xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.9", "assigningAuthorityName" => "HITSP/C32") 
            xml.manufacturedMaterial("classCode" => "MMAT", "determinerCode" => "KIND") {
              
             if(product_code && !product_code.blank? && code_system && !code_system.blank?)
              xml.code("code" => product_code, 
                       "displayName" => product_coded_display_name, 
                       "codeSystem" => code_system.code, 
                       "codeSystemName" => code_system.name){
                           xml.originalText(product_coded_display_name)
                       } 
               end         
              if free_text_brand_name 
                xml.name free_text_brand_name
              end
            }
          }
        }
        
        if medication_type
          xml.entryRelationship("typeCode" => "SUBJ") {
            xml.observation("classCode" => "OBS", "moodCode" => "EVN") {                           
              xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.10") 
              xml.code("code" => medication_type.code, 
                       "displayName" => medication_type.name, 
                       "codeSystem" => "2.16.840.1.113883.6.96", 
                       "codeSystemName" => "SNOMED CT")
              xml.statusCode("code" => "completed")
            }  
          }
        end
        
        if status
          xml.entryRelationship("typeCode" => "REFR") {
            xml.observation("classCode" => "OBS", "moodCode" => "EVN") {
              xml.code("code" => "33999-4", 
                       "displayName" => "Status", 
                       "codeSystem" => "2.16.840.1.113883.6.1", 
                       "codeSystemName" => "LOINC")
              xml.statusCode("code" =>status)
              xml.value("xsi:type" => "CE", 
                        "code" => "55561003", 
                        "displayName" => "Active", 
                        "codeSystem" => "2.16.840.1.113883.6.96", 
                        "codeSystemName" => "SNOMED CT")
            }
          }
        end
        
        if quantity_ordered_value  || quantity_ordered_unit  || expiration_time 
          xml.entryRelationship("typeCode" => "REFR") {
            xml.supply("classCode" => "SPLY", "moodCode" => "INT") {
              xml.templateId("root" => "2.16.840.1.113883.3.88.1.11.32.11")
              if quantity_ordered_unit 
                xml.id("root" => quantity_ordered_unit, "extension" => "SCRIP#")
              end 
              if expiration_time 
                  xml.effectiveTime("value" => expiration_time.strftime("%Y%m%d"))
              end
              if quantity_ordered_value 
                xml.quantity("value" => quantity_ordered_value)
              end  
            }
          }
        end
        
      }
    }
  end
  
  def randomize()
    @product_names = ["Metoprolol", "Cephalexin", "Albuterol inhalant", "Prednisone", "Clopidogrel"]
    @product_codes = [430618, 197454, 307782, 312615, 309362]
    @brand_names = ["Generic Brand",  "Keflex", "ACTUAT inhalant", "", "Plavix"]
    @index = rand(6)

    self.product_coded_display_name = @product_names[@index]
    self.product_code = @product_codes[@index]
    self.code_system = CodeSystem.find 353033998
    self.free_text_brand_name = @brand_names[@index]
    self.medication_type = MedicationType.find(:all).sort_by{rand}.first
    self.expiration_time = DateTime.new(2008 + rand(4), rand(12) + 1, rand(28) + 1)
  end
  
end
