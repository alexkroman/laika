class RegistrationInformation < ActiveRecord::Base
  belongs_to :patient_data
  include PersonLike
  
  def validate_c32(document)
    errors = []
    patient_element = REXML::XPath.first(document, '/cda:ClinicalDocument/cda:recordTarget/cda:patientRole', {'cda' => 'urn:hl7-org:v3'})
    if patient_element
      errors << XmlHelper.match_value(patient_element, 'cda:id/@extension', self.person_identifier)
      # TODO: Need to deal with more than a single name being present
      # errors << XpathExpression.match_value(patient_element, 'name_prefix', doc_type, self.person_name.name_prefix)
      # errors << XpathExpression.match_value(patient_element, 'first_name', doc_type, self.person_name.first_name)
      # errors << XpathExpression.match_value(patient_element, 'last_name', doc_type, self.person_name.last_name)
      # errors << XpathExpression.match_value(patient_element, 'name_suffix', doc_type, self.person_name.name_suffix)
      # errors << XpathExpression.match_value(patient_element, 'patient_gender', doc_type, self.gender)
      # # TODO: Need to verfiy birth date somehow... unclear how to do this from the CDA/CCD/C32 specs
      # errors << XpathExpression.match_value(patient_element, 'patient_marital_status', doc_type, self.marital_status)
    else
      errors << ContentError.new(:section => 'registration_information', :error_message => 'No patientRole element found')
    end
    
    errors.compact
  end
end
