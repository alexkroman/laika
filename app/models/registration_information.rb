class RegistrationInformation < ActiveRecord::Base
  belongs_to :patient_data
  include PersonLike
  
  def check_content(document, doc_type)
    errors = []
    patient_element = XpathExpression.execute_expression_against_element(document, 'registration_information_context', doc_type)
    if patient_element
      errors << XpathExpression.match_value(patient_element, 'person_identifier', doc_type, self.person_identifier)
      # TODO: Need to deal with more than a single name being present
      errors << XpathExpression.match_value(patient_element, 'name_prefix', doc_type, self.person_name.name_prefix)
      errors << XpathExpression.match_value(patient_element, 'first_name', doc_type, self.person_name.first_name)
      errors << XpathExpression.match_value(patient_element, 'last_name', doc_type, self.person_name.last_name)
      errors << XpathExpression.match_value(patient_element, 'name_suffix', doc_type, self.person_name.name_suffix)
      errors << XpathExpression.match_value(patient_element, 'patient_gender', doc_type, self.gender)
      # TODO: Need to verfiy birth date somehow... unclear how to do this from the CDA/CCD/C32 specs
      errors << XpathExpression.match_value(patient_element, 'patient_marital_status', doc_type, self.marital_status)
    else
      errors << "Couldn't find the patient element in the document"
    end
    
    errors.compact
  end
end
