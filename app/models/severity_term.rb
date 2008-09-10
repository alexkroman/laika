class SeverityTerm < ActiveRecord::Base

  include MatchHelper

  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}

  def validate_c32(severity_element)
    errors = []
    severity_text = REXML::XPath.first(severity_element,"cda:text",@@default_namespaces)
    if severity_text
      derefed_text = deref(severity_text)
      if derefed_text != self.name
        errors << ContentError.new(:section => "Allergies", :subsection => "SeverityTerm",
                                   :error_message => "Severity term #{self.name} does not match #{derefed_text}",
                                   :location => severity_text.xpath)
      end
    else
      errors << ContentError.new(:section => "Allergies", :subsection => "SeverityTerm",
                                 :error_message => "Unable to find severity term text",
                                 :location => severity_element.xpath)
    end
    errors << match_value(severity_element, 'cda:value/@code', 'code', self.code)
    errors.compact
  end

  def section_name
    'allergies'
  end

  def subsection_name
    'severity'
  end

  # TODO: Pull this code out into a helper module
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
