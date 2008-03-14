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
        errors.concat dvance_directive_type.validate_c32(code)
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
  
  private 
  def deref(code)
     if code
        ref = REXML::XPath.first(code,"cda:reference",@@default_namespaces)
        if ref
           val = REXML::XPath.first(code.document,"//cda:content[@ID=$id]/text()",@@default_namespaces,{"id"=>ref.attributes['value'].gsub("#",'')}) 
           puts val
           val
        else
            
        end
     end 
  end
end
