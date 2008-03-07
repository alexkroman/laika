class SeverityTerm < ActiveRecord::Base
  
  include MatchHelper

  def validate_c32(severity_element)
    errors = []
    errors << match_value(severity_element, 'cda:text', 'name', self.name)
    errors << match_value(severity_element, 'cda:value/@code', 'code', self.code)
    errors.compact
  end

  def section_name
    'allergies'
  end
  
  def subsection_name
    'severity'
  end

end
