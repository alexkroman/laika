class Medication < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :medication_type
  belongs_to :code_system
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def validate_c32(xml)
    errors=[]
    context = REXML::XPath.first(xml,"//cda:section[./cda:templateId[@root eq '2.16.840.1.113883.10.20.1.8']]",@@default_namespaces )
    # IF there is an entry for this medication then there will be a substanceAdministration element
    # that contains a consumable that contains a manufacturedProduct that has a code with the original text 
    # equal to the name of the generic medication
    # the consumeable/manfucaturedProduct/code/originalText is a required field if the substanceAdministration entry is there
    substance_administration = REXML::XPath.first(context,"./cda:entry/cda:substanceAdministration[ ./cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/cda:originalText/text() = $original]",@@default_namespaces,{"original"=>product_coded_display_name} )

    if substance_administration then    
      #consumable product and assorted sub elements
      consumable = REXML::XPath.first(substance_administration,"./cda:consumable",@@default_namespaces)
      manufactured = REXML::XPath.first(consumable,"./cda:manufacturedProduct",@@default_namespaces)
      code = REXML::XPath.first(manufactured,"./cda:manufacturedMaterial/cda:code",@@default_namespaces)
      translation = REXML::XPath.first(code,"cda:translation",@@default_namespaces)

      # look for the Brand information if it exists
      errors << match_value(manufactured, "cda:manufacturedMaterial/cda:name/text()", 'free_text_brand_name', free_text_brand_name)

      # validate the medication type Perscription or over the counter
      errors << match_value(substance_administration, 
                           "cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.3.88.11.32.10']/cda:code/@displayName",
                           'medication_type', medication_type.name)

      # validate the status
      errors << match_value(substance_administration,
         "cda:entryRelationship[@typeCode='REFR']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.47']/cda:value/@code", 'status', status)

      # validate the order quantity
      order = REXML::XPath.first(substance_administration,
         "cda:entryRelationship[@typeCode='REFR']/cda:supply[@moodCode='INT']", @@default_namespaces)
      if order
        errors << match_value(order, "cda:quantity/@value", "quantity_ordered_value", quantity_ordered_value)
        errors << match_value(order, "cda:effectiveTime/cda:high/@value", "expiration_time", expiration_time.andand.to_formatted_s(:hl7_ts))
      end

    else
      errors << ContentError.new(:section => "Medication", 
                                 :subsection => "substanceAdministration",
                                 :error_message =>"A substanceAdministration section does not exist for the medication")

        # could not find the entry so lets report the error 
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
          xml.manufacturedProduct ("classCode" => "MANU") {
            xml.templateId("root" => "2.16.840.1.113883.10.20.1.53", "assigningAuthorityName" => "CCD") 
            xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.9", "assigningAuthorityName" => "HITSP/C32") 
            xml.manufacturedMaterial("classCode" => "MMAT", "determinerCode" => "KIND") {
              xml.code("code" => "161", "displayName" => "Acetaminophen", "codeSystem" => "2.16.840.1.113883.6.88", "codeSystemName" => "RxNorm") {
                xml.originalText "Acetaminophen"
                xml.translation("code" => "202433", "displayName" => "Tylenol", "codeSystem" => "2.16.840.1.113883.6.88", "codeSystemName" => "RxNorm")
              }
              xml.name "Tylenol"
            }
          }
        }
      }
    }

  end
  
end