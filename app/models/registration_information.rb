class RegistrationInformation < ActiveRecord::Base
  belongs_to :patient_data
  belongs_to :race
  belongs_to :ethnicity
  belongs_to :marital_status
  belongs_to :gender
  belongs_to :religion
  include PersonLike
  
  # Checks the contents of the REXML::Document passed in to make sure that they match the
  # information in this object. Will return an empty array if everything passes. Otherwise,
  # it will return an array of ContentErrors with a description of what's wrong.
  def validate_c32(document)
    errors = []
    patient_element = REXML::XPath.first(document, '/cda:ClinicalDocument/cda:recordTarget/cda:patientRole', {'cda' => 'urn:hl7-org:v3'})
    if patient_element
      errors << XmlHelper.match_value(patient_element, 'cda:id/@extension', self.person_identifier)
      name_element = REXML::XPath.first(patient_element, 
                                        "cda:patient/cda:name[cda:given='#{self.person_name.first_name}' and cda:family='#{self.person_name.last_name}']",
                                        {'cda' => 'urn:hl7-org:v3'})
      errors.concat(self.person_name.validate_c32(name_element))
      errors.concat(self.telecom.validate_c32(patient_element))
      if self.address.street_address_line_one
        address_element = REXML::XPath.first(patient_element, 
                                             "cda:addr[cda:streetAddressLine[1]='#{self.address.street_address_line_one}']",
                                             {'cda' => 'urn:hl7-org:v3'})
        errors.concat(self.address.validate_c32(address_element))
      end
      errors << XmlHelper.match_value(patient_element, 'cda:patient/cda:administrativeGenderCode/@code', self.gender)
      # TODO: Need to verfiy birth date somehow... unclear how to do this from the CDA/CCD/C32 specs
      errors << XmlHelper.match_value(patient_element, 'cda:patient/cda:maritalStatusCode/@code', self.marital_status)
    else
      errors << ContentError.new(:section => 'registration_information', :error_message => 'No patientRole element found')
    end
    
    errors.compact
  end
end
