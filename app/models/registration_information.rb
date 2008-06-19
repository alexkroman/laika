class RegistrationInformation < ActiveRecord::Base
  
  strip_attributes!

  belongs_to :patient_data
  belongs_to :race
  belongs_to :ethnicity
  belongs_to :marital_status
  belongs_to :gender
  belongs_to :religion

  include PersonLike
  include MatchHelper
  
  def view
    v = Laika::UIBuilder::View.new(self)
    v.add_field(:person_name, :subattribute => :name_prefix)
    v.add_field(:person_name, :subattribute => :first_name)
    v.add_field(:person_name, :subattribute => :last_name)
    v.add_field(:person_name, :subattribute => :name_suffix)
    v.add_field(:gender)
    v.add_field(:date_of_birth)
    v.add_field(:marital_status)
    v.add_field(:religion)
    v.add_field(:race)
    v.add_field(:ethnicity)
    v.add_field(:address, :subattribute => :street_address_line_one, :label => 'Street address')
    v.add_field(:address, :subattribute => :street_address_line_two, :label => '')
    v.add_field(:address, :subattribute => :city)
    v.add_field(:address, :subattribute => :state, :collection => Laika::Constants::STATES)
    v.add_field(:address, :subattribute => :postal_code)
    v.add_field(:address, :subattribute => :iso_country, :label => 'Country')
    v.add_field(:telecom, :subattribute => :home_phone)
    v.add_field(:telecom, :subattribute => :work_phone)
    v.add_field(:telecom, :subattribute => :mobile_phone)
    v.add_field(:telecom, :subattribute => :vacation_home_phone)
    v.add_field(:telecom, :subattribute => :email)
    v.add_field(:telecom, :subattribute => :url)
    v
  end
  
  
  # Checks the contents of the REXML::Document passed in to make sure that they match the
  # information in this object. Will return an empty array if everything passes. Otherwise,
  # it will return an array of ContentErrors with a description of what's wrong.
  def validate_c32(document)
    errors = []
    begin
      patient_element = REXML::XPath.first(document, '/cda:ClinicalDocument/cda:recordTarget/cda:patientRole', {'cda' => 'urn:hl7-org:v3'})
      if patient_element
        #errors << match_value(patient_element, 'cda:id/@extension', 'person_identifier', self.person_identifier)
        name_element = REXML::XPath.first(patient_element, 
                                          "cda:patient/cda:name[cda:given='#{self.person_name.first_name}' and cda:family='#{self.person_name.last_name}']",
                                          {'cda' => 'urn:hl7-org:v3'})
        if name_element
          errors.concat(self.person_name.validate_c32(name_element))
        else
          errors << ContentError.new(:section => 'registration_information', 
                                     :subsection => 'person_name',
                                     :error_message => "Couldn't find the patient's name",
                                     :type=>'error',
                                     :location=>patient_element.xpath)
        end
        errors.concat(self.telecom.validate_c32(patient_element))
        if self.address.street_address_line_one
          address_element = REXML::XPath.first(patient_element, 
                                               "cda:addr[cda:streetAddressLine[1]='#{self.address.street_address_line_one}']",
                                               {'cda' => 'urn:hl7-org:v3'})
          errors.concat(self.address.validate_c32(address_element))
        end
        errors << match_value(patient_element, 'cda:patient/cda:administrativeGenderCode/@code', 'gender', self.gender.andand.code)
        errors << match_value(patient_element, 'cda:patient/cda:administrativeGenderCode/@displayName', 'gender', self.gender.andand.name)
      
        errors << match_value(patient_element, 'cda:patient/cda:maritalStatusCode/@code', 'marital_status', self.marital_status.andand.code)
        errors << match_value(patient_element, 'cda:patient/cda:maritalStatusCode/@displayName', 'marital_status', self.marital_status.andand.name)
      
        errors << match_value(patient_element, 'cda:patient/cda:religiousAffiliationCode/@code', 'religion', self.religion.andand.code)
        errors << match_value(patient_element, 'cda:patient/cda:religiousAffiliationCode/@displayName', 'religion', self.religion.andand.name)
      
        errors << match_value(patient_element, 'cda:patient/cda:raceCode/@code', 'race', self.race.andand.code)
        errors << match_value(patient_element, 'cda:patient/cda:raceCode/@displayName', 'race', self.race.andand.name)
      
        errors << match_value(patient_element, 'cda:patient/cda:ethnicGroupCode/@code', 'ethnicity', self.ethnicity.andand.code)
        errors << match_value(patient_element, 'cda:patient/cda:ethnicGroupCode/@displayName', 'ethnicity', self.ethnicity.andand.name)
      
        errors << match_value(patient_element, 'cda:patient/cda:birthTime/@value', 'date_of_birth', self.date_of_birth.andand.to_formatted_s(:hl7_ts))
      else
        errors << ContentError.new(:section => 'registration_information', 
                                   :error_message => 'No patientRole element found',
                                   :location => document.xpath)
      end
    rescue
      errors << ContentError.new(:section => 'registration_information', 
                                 :error_message => 'Invalid, non-parsable XML for registration data',
                                 :type=>'error',
                                 :location => document.xpath)
    end
    errors.compact
  end
  
  
  def to_c32(xml = Builder::XmlMarkup.new)
    xml.id("extension" => "1234567890")
    
    address.andand.to_c32(xml)
    telecom.andand.to_c32(xml)
    
    xml.patient { 
      person_name.andand.to_c32(xml)
      gender.andand.to_c32(xml)
      if date_of_birth
        xml.birthTime("value" => date_of_birth.strftime("%Y%m%d"))  
      end      
      marital_status.andand.to_c32(xml)
      religion.andand.to_c32(xml)
      race.andand.to_c32(xml)
      ethnicity.andand.to_c32(xml)
      
      # do the gaurdian stuff here non gaurdian is placed elsewhere
      if patient_data.support &&
         patient_data.support.contact_type &&
         patient_data.support.contact_type.code == "GUARD"
        patient_data.support.to_c32(xml)
      end  
      
      patient_data.languages.andand.each do |language|
        language.to_c32(xml)
      end 
    }
  end
end
