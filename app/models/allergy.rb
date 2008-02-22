class Allergy < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :adverse_event_type
  belongs_to :severity_term
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  
  # FIXME: This doesn't work yet
  def validate_c32(document)
    errors = []
    section = REXML::XPath.first(document,"//cda:section[./cda:templateId[@root eq '2.16.840.1.113883.10.20.1.2']]",@@default_namespaces )
    # To find the allergy we are looking for, we know that the product free text name will always be there
    # below is the monster XPath expression to find it
    xpath = <<XPATH
    cda:entry/
    cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']/ 
    cda:entryRelationship[@typeCode='SUBJ']/ 
    cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.18' and cda:participant[@typeCode='CSM']/
      cda:participantRole[@classCode='MANU']/  
      cda:playingEntity[@classCode='MMAT']/
      cda:name/text() = $free_text_product] 
XPATH
    #strip out all of the whitespace at the beginning and end of the expression
    xpath.gsub!(/^\s/, '')
    xpath.gsub!(/\s$/, '')
    adverse_event = REXML::XPath.first(section, xpath, @@default_namespaces, {"original" => free_text_product})
    if adverse_event
      errors << match_value(adverse_event, "cda:participant[@typeCode='CSM']/cda:participantRole[@classCode='MANU']/cda:playingEntity[@classCode='MMAT']/cda:name", 
                            'free_text_product', self.free_text_product)
      if self.severity_term
      
        severity_element = REXML::XPath.first(adverse_event, "cda:entryRelationship[@typeCode='SUBJ']/cda:observation[templateId/@root='2.16.840.1.113883.10.20.1.55']",
                                              @@default_namespaces)
        if severity_element
          errors << self.severity_term.validate_c32(severity_element)
        else
          errors << ContentError.new(:section => 'allergies', :subsection => 'severity_term', :error_message => "Unable to find severity")
        end
      end
    else
      errors << ContentError.new(:section => 'allergies', :error_message => "Unable to find product #{free_text_product}")
    end
    
    errors.compact
  end
  
  private 
  
  def match_value(name_element, xpath, field, value)
    error = XmlHelper.match_value(name_element, xpath, value)
    if error
      return ContentError.new(:section => 'allergies', :field_name => field,
                              :error_message => error)
    else
      return nil
    end
  end
end
