class AdvanceDirective < ActiveRecord::Base  
  strip_attributes!
    
  belongs_to :patient_data  
  belongs_to :advance_directive_type
  include PersonLike
  
  include MatchHelper

  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def validate_c32(doc)
    
    errors = []
    section = REXML::XPath.first(doc,"//cda:section[cda:templateId/@root='2.16.840.1.113883.10.20.1.1']",@@default_namespaces)
    observation = REXML::XPath.first(section,"cda:entry/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.17']",@@default_namespaces)
      # match person type info
    entity = REXML::XPath.first(observation,"cda:participant[@typeCode='CST']/cda:participantRole[@classCode='AGNT']",@@default_namespaces)
    code = REXML::XPath.first(observation,"cda:code",@@default_namespaces)
    text =  REXML::XPath.first(code,"cda:originalText",@@default_namespaces)
    deref_text = deref(text)
    
    if advance_directive_type
        errors.concat advance_directive_type.validate_c32(code)
    end
    
    if(deref_text != free_text)
        errors << ContentError.new(:section=>"Advance Directive",
                :error_message=>"Directive text #{free_text} does not match #{deref_text}",
                :location=>(text)? text.xpath : (code)? code.xpath : section.xpath )
    end
    
    if person_name
       errors.concat  person_name.validate_c32(REXML::XPath.first(entity,'cda:playingEntity/cda:name',@@default_namespaces))
    end
             
    if address
      errors.concat address.validate_c32(REXML::XPath.first(entity,'cda:addr',@@default_namespaces))
    end
     
    if telecom
       errors.concat telecom.validate_c32(entity)
    end      
    
    return errors.compact
  end
  
  #FIXME: Need to put in the directive text
  def to_c32(xml)
    
    xml.entry {
      xml.observation("classCode" => "OBS", "moodCode" => "EVN") {
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.17", "assigningAuthorityName" => "CCD")
        xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.13", "assigningAuthorityName" => "HITSP/C32")
        xml.id
        xml.code ("code" => advance_directive_type.code, 
                  "displayName" => advance_directive_type.name, 
                  "codeSystem" => "2.16.840.1.113883.6.96",
                  "codeSystemName" => "SNOMED CT") {
          xml.originalText {
            xml.reference("value" => "advance-directive-" + id.to_s)
          }
        }
        xml.statusCode("code" => "completed")
        
        if start_effective_time != nil || start_effective_time != nil
          xml.effectiveTime {
            if start_effective_time != nil 
              xml.low("value" => start_effective_time.strftime("%Y%m%d"))
            end
            if end_effective_time != nil
              xml.high("value" => end_effective_time.strftime("%Y%m%d"))
            else
              xml.high("nullFlavor" => "UNK")
            end
          }
        end
        
        xml.participant("typeCode" => "CST") {
          xml.participantRole("classCode" => "AGNT") {
            address.andand.to_c32(xml)
            telecom.andand.to_c32(xml) 
            xml.playingEntity {
              person_name.andand.to_c32(xml)
            }
          }
        }
      }
    }
    
  end
  
  private 
  def deref(code)
      if code
         ref = REXML::XPath.first(code,"cda:reference",@@default_namespaces)
         if ref
            REXML::XPath.first(code.document,"//cda:content[@ID=$id]/text()",@@default_namespaces,{"id"=>ref.attributes['value'].gsub("#",'')}) 
         else
            nil
         end
      end 
  end
 
end
