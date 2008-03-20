class Provider < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :provider_type
  belongs_to :provider_role
  
  include PersonLike
  
  include MatchHelper
  def validate_c32(document)
     namespaces = {'cda'=>"urn:hl7-org:v3",'sdtc'=>"urn:hl7-org:sdtc"}
     errors = []
     provider = REXML::XPath.first(document,'/cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent/cda:performer',namespaces)
     
     unless provider
       return [ContentError.new(:section => 'Provider', :error_message => "Provider not found", :location => document.andand.xpath)]    
     end
     
     date_range =REXML::XPath.first(provider, 'cda:time',namespaces)
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
               errors << ContentError.new(:section=>section,:error_message=>"Expected to find a patient identifier with the value of #{patient_identifier}",:location=>assigned.xpath)
           end
          end         
         
    else
        errors << ContentError.new(:section=>section,:error_message=>"Assigned person not found",:location=>(document) ? document.xpath : nil)
    end
    return errors.compact
 end
 
 
 def to_c32(xml)

        xml.performer("typeCode" => "PRF") {
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
      }

 end
 
end
