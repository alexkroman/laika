xml.ClinicalDocument("xsi:schemaLocation" => "urn:hl7-org:v3 http://xreg2.nist.gov:8080/hitspValidation/schema/cdar2c32/infrastructure/cda/C32_CDA.xsd", 
                     "xmlns" => "urn:hl7-org:v3", 
                     "xmlns:sdct" => "urn:hl7-org:sdct", 
                     "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance") {
  xml.typeId("root" => "2.16.840.1.113883.1.3", 
             "extension" => "POCD_HD000040")
  xml.templateId("root" => "2.16.840.1.113883.3.27.1776", 
                 "assigningAuthorityName" => "CDA/R2")
  xml.templateId("root" => "2.16.840.1.113883.10.20.1", 
                 "assigningAuthorityName" => "CCD")
  xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.1", 
                 "assigningAuthorityName" => "HITSP/C32")
  xml.id("root" => "2.16.840.1.113883.3.72", 
         "extension" => "Laika C32 Test", 
         "assigningAuthorityName" => "Laika: An Open Source EHR Testing Framework projectlaika.org")
  xml.code("code" => "34133-9", 
           "displayName" => "Summarization of patient data", 
           "codeSystem" => "2.16.840.1.113883.6.1", 
           "codeSystemName" => "LOINC")
  xml.title @patient_data.name
  xml.effectiveTime("vale" => @patient_data.updated_at.strftime("%Y%m%d%H%M%S-0500"))
  xml.confidentialityCode
  xml.languageCode("code" => "en-US")
  xml.recordTarget {
    xml.patientRole
    xml.id("extension" => "24602", 
           "root" => "SomeClinicalOrganizationOID", 
           "assignmentAuthorityName" => "Some Clinical Organization Name") 
    if @patient_data.registration_information
      if @patient_data.registration_information.telecom 
        if @patient_data.registration_information.telecom.home_phone && 
           @patient_data.registration_information.telecom.home_phone.size > 0
          xml.telecom("use" => "HP", "value" => @patient_data.registration_information.telecom.home_phone)
        end
        if @patient_data.registration_information.telecom.work_phone && 
          @patient_data.registration_information.telecom.work_phone.size > 0
         xml.telecom("use" => "WP", "value" => @patient_data.registration_information.telecom.work_phone)
        end
        if @patient_data.registration_information.telecom.mobile_phone && 
           @patient_data.registration_information.telecom.mobile_phone.size > 0
          xml.telecom("use" => "MC", "value" => @patient_data.registration_information.telecom.mobile_phone)
        end
        if @patient_data.registration_information.telecom.vacation_home_phone && 
           @patient_data.registration_information.telecom.vacation_home_phone.size > 0
          xml.telecom("use" => "HV", "value" => @patient_data.registration_information.telecom.vacation_home_phone)
        end
      end
      if @patient_data.registration_information.address
        xml.addr {
          if @patient_data.registration_information.address.street_address_line_one &&
             @patient_data.registration_information.address.street_address_line_one.size > 0
            xml.streetAddressLine @patient_data.registration_information.address.street_address_line_one
          end
          if @patient_data.registration_information.address.street_address_line_two &&
             @patient_data.registration_information.address.street_address_line_two.size > 0
            xml.streetAddressLine @patient_data.registration_information.address.street_address_line_two
          end
          if @patient_data.registration_information.address.city &&
             @patient_data.registration_information.address.city.size > 0
            xml.city @patient_data.registration_information.address.city
          end
          if @patient_data.registration_information.address.state &&
             @patient_data.registration_information.address.state.size > 0
            xml.state @patient_data.registration_information.address.state
          end
          if @patient_data.registration_information.address.postal_code &&
             @patient_data.registration_information.address.postal_code.size > 0
            xml.postalCode @patient_data.registration_information.address.postal_code
          end
          if @patient_data.registration_information.address.iso_country 
            xml.country @patient_data.registration_information.address.iso_country.code
          end
        }
      end
      xml.patient {
        if @patient_data.registration_information.person_name 
          xml.name {
            if @patient_data.registration_information.person_name.name_prefix &&
               @patient_data.registration_information.person_name.name_prefix.size > 0
              xml.prefix @patient_data.registration_information.person_name.name_prefix
            end
            if @patient_data.registration_information.person_name.first_name &&
               @patient_data.registration_information.person_name.first_name.size > 0
              xml.given(@patient_data.registration_information.person_name.first_name, "qualifier" => "CL")
            end
            if @patient_data.registration_information.person_name.last_name &&
               @patient_data.registration_information.person_name.last_name.size > 0
              xml.family (@patient_data.registration_information.person_name.last_name, "qualifier" => "BR")
            end
            if @patient_data.registration_information.person_name.name_suffix &&
               @patient_data.registration_information.person_name.name_suffix.size > 0
              xml.prefix @patient_data.registration_information.person_name.name_suffix
            end
          }
        end 
        if @patient_data.registration_information.gender
          xml.administrativeGenderCode("code" => @patient_data.registration_information.gender.code, 
                                       "displayName" => @patient_data.registration_information.gender.name, 
                                       "codeSystemName" => "HL7 AdministrativeGenderCodes", 
                                       "codeSystem" => "2.16.840.1.113883.5.1") {
            xml.originalText "AdministrativeGender codes are: M (Male), F (Female) or UN (Undifferentiated)."  
          } 
        end
        if @patient_data.registration_information.date_of_birth
          xml.birthTime("value" => @patient_data.registration_information.date_of_birth.strftime("%Y%m%d"))  
        end
        if @patient_data.languages
          @patient_data.languages.each { |language|
            xml.languageCommunication {
              xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.2")
              xml.languageCode("code" => language.iso_language.code + "-" +language.iso_country.code,
                               "displayName" => language.iso_language.name) 
            }
          }
        end  
      }
    end
  }
}