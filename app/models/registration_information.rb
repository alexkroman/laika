class RegistrationInformation < ActiveRecord::Base
  strip_attributes!

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
      errors << match_value(patient_element, 'cda:id/@extension', 'person_identifier', self.person_identifier)
      name_element = REXML::XPath.first(patient_element, 
                                        "cda:patient/cda:name[cda:given='#{self.person_name.first_name}' and cda:family='#{self.person_name.last_name}']",
                                        {'cda' => 'urn:hl7-org:v3'})
      if name_element
        errors.concat(self.person_name.validate_c32(name_element))
      else
        errors << ContentError.new(:section => 'registration_information', :subsection => 'person_name',
                                   :error_message => "Couldn't find the patient's name")
      end
      errors.concat(self.telecom.validate_c32(patient_element))
      if self.address.street_address_line_one
        address_element = REXML::XPath.first(patient_element, 
                                             "cda:addr[cda:streetAddressLine[1]='#{self.address.street_address_line_one}']",
                                             {'cda' => 'urn:hl7-org:v3'})
        errors.concat(self.address.validate_c32(address_element))
      end
      
      if self.gender
        errors << match_value(patient_element, 'cda:patient/cda:administrativeGenderCode/@code', 'gender', self.gender.code)
      end
      
      # TODO: Need to verfiy birth date somehow... unclear how to do this from the CDA/CCD/C32 specs
      if self.marital_status
        errors << match_value(patient_element, 'cda:patient/cda:maritalStatusCode/@code', 'marital_status', self.marital_status.code)
      end
    else
      errors << ContentError.new(:section => 'registration_information', :error_message => 'No patientRole element found')
    end
    
    errors.compact
  end
  
  private
  
  def match_value(name_element, xpath, field, value)
    error = XmlHelper.match_value(name_element, xpath, value)
    if error
      return ContentError.new(:section => 'registration_information', :field_name => field,
                              :error_message => error)
    else
      return nil
    end
  end
  
end
