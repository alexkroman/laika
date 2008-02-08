class RegistrationInformation < ActiveRecord::Base
  belongs_to :patient_data
  include PersonLike
  
  def check_content(document, doc_type)
    errors = []
    patient_element = XpathExpression.execute_expression_against_element(document, 'registration_information_context', doc_type)
    if patient_element
      errors << XpathExpression.match_value(patient_element, 'person_identifier', doc_type, self.person_identifier)
    else
      errors << "Couldn't find the patient element in the document"
    end
    
    errors.compact
  end
end
