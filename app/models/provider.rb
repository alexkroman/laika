class Provider < ActiveRecord::Base

  strip_attributes!

  belongs_to :patient_data
  belongs_to :provider_type
  belongs_to :provider_role

  include PersonLike
  include MatchHelper

  def requirements
    {
      :start_service => :hitsp_optional,
      :end_service => :hitsp_optional,
      :provider_type_id => :hitsp_r2_optional,
      :provider_role_id => :hitsp_r2_optional,
      :provider_role_free_text => :hitsp_r2_optional,
      :organization => :hitsp_r2_optional,
      :patient_identifier => :hitsp_r2_optional,
    }
  end

  #Reimplementing from MatchHelper
  def section_name
    "Healthcare Providers Module"
  end

  def validate_c32(document)
    errors = []
    begin
      namespaces = {'cda'=>"urn:hl7-org:v3",'sdtc'=>"urn:hl7-org:sdtc"}
      provider = REXML::XPath.first(document,'/cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent/cda:performer',namespaces)
      unless provider
        return [ContentError.new(:section => 'Provider', 
                                 :error_message => "Provider not found", 
                                 :location => document.andand.xpath)]    
      end     
      date_range = REXML::XPath.first(provider, 'cda:time',namespaces)
      assigned = REXML::XPath.first(provider,'cda:assignedEntity',namespaces)
      if assigned
        if provider_role
          errors.concat  provider_role.validate_c32(REXML::XPath.first(provider,'cda:functionCode',namespaces))
        end
        if provider_type
          errors.concat provider_type.validate_c32(REXML::XPath.first(assigned,'cda:code',namespaces))
        end
        if person_name
           errors.concat  person_name.validate_c32(REXML::XPath.first(assigned,'cda:assignedPerson/cda:name',namespaces))
        end 
        if address
          errors.concat address.validate_c32(REXML::XPath.first(assigned,'cda:addr',namespaces))
        end
        if telecom
          errors.concat telecom.validate_c32(assigned)
        end
         
        if patient_identifier
          id = REXML::XPath.first(assigned,'sdtc:patient/sdtc:id',namespaces)
          if id
            errors << match_value(id,'@root','id',patient_identifier)
          else
            errors << ContentError.new(:section => section,
                                       :error_message => "Expected to find a patient identifier with the value of #{patient_identifier}",
                                       :location => assigned.xpath)
          end
        end         
      else
        errors << ContentError.new(:section=>section,
                                   :error_message=>"Assigned person not found",
                                   :location=>(document) ? document.xpath : nil)
      end
    rescue
      errors << ContentError.new(:section => 'HealthCare Provider', 
                                 :error_message => 'Invalid, non-parsable XML for HealthCare Provider data',
                                 :type=>'error',
                                 :location => document.xpath)
    end
    errors.compact
  end

  def to_c32(xml)
    xml.performer("typeCode" => "PRF") do
      xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.4", 
                     "assigningAuthorityName" => "HITSP/C32")
      unless provider_role.blank?
        provider_role.to_c32(xml,provider_role_free_text)
      end
    
      xml.time do
        if start_service 
          xml.low('value'=> start_service.strftime("%Y%m%d"))
        end
        if end_service 
          xml.high('value'=> end_service.strftime("%Y%m%d"))
        end
      end

      xml.assignedEntity do
        xml.id
        provider_type.andand.to_c32(xml)
        address.andand.to_c32(xml)
        telecom.andand.to_c32(xml)  
        xml.assignedPerson do
          person_name.andand.to_c32(xml)
        end

        unless organization.blank?
          xml.representedOrganization do
            xml.id("root" => "2.16.840.1.113883.3.72.5", 
                   "assigningAuthorityName" => organization) 
            xml.name(organization)
          end
        end

        unless patient_identifier.blank?
          xml.patient("xmlns"=>"urn:hl7-org:sdtc") do
            xml.id("xmlns"=>"urn:hl7-org:sdtc","root" => patient_identifier,
                   "extension" => "MedicalRecordNumber")
          end
        end
      end
    end
  end

  def randomize(reg_info)
    self.address = Address.new
    self.person_name = PersonName.new
    self.telecom = Telecom.new
    self.person_name.first_name = Faker::Name.first_name
    self.person_name.last_name = Faker::Name.last_name

    self.start_service = DateTime.new(reg_info.date_of_birth.year + rand(DateTime.now.year - reg_info.date_of_birth.year), rand(12) + 1, rand(28) + 1)
    self.end_service = DateTime.new(self.start_service.year + rand(DateTime.now.year - self.start_service.year), rand(12) + 1, rand(28) + 1)

    self.provider_type = ProviderType.find(:all).sort_by{rand}.first
    self.provider_role = ProviderRole.find(:all).sort_by{rand}.first

    #Creates the address of the healthcare provider. Makes it in the same state/town as the patient
    self.address.street_address_line_one = Faker::Address.street_address
    self.address.city = reg_info.address.city
    self.address.state = reg_info.address.state
    self.address.iso_country = reg_info.address.iso_country
    self.address.postal_code = reg_info.address.postal_code

    self.telecom.randomize()
  end

end
