class SeverityTerm < ActiveRecord::Base

  def validate_c32(severity_element)
    errors = []
    errors << match_value(severity_element, 'cda:text', 'name', self.name)
    errors << match_value(severity_element, 'cda:value/@code', 'code', self.code)
    errors.compact
  end
  
  private
  
  def match_value(name_element, xpath, field, value)
    error = XmlHelper.match_value(name_element, xpath, value)
    if error
      return ContentError.new(:section => 'allergies', :subsection => 'severity', :field_name => field,
                              :error_message => error,
                              :location=>(name_element) ? name_element.xpath : nil)
    else
      return nil
    end
  end
end
