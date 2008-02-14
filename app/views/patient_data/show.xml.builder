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
    
      # Start registration telecoms
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
        if @patient_data.registration_information.telecom.email && 
           @patient_data.registration_information.telecom.email.size > 0
          xml.telecom("value" => "mailto:" + @patient_data.registration_information.telecom.email)
        end
        if @patient_data.registration_information.telecom.url && 
           @patient_data.registration_information.telecom.url.size > 0
          xml.telecom("value" => @patient_data.registration_information.telecom.url)
        end
      end
      # End registration telecoms
      
      # Start registration address
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
      # End registration address
      
      # Start patient    
      xml.patient {
      
         # Start patient name
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
        # End patient name
        
        # Start patient gender
        if @patient_data.registration_information.gender
          xml.administrativeGenderCode("code" => @patient_data.registration_information.gender.code, 
                                       "displayName" => @patient_data.registration_information.gender.name, 
                                       "codeSystemName" => "HL7 AdministrativeGenderCodes", 
                                       "codeSystem" => "2.16.840.1.113883.5.1") {
            xml.originalText "AdministrativeGender codes are: M (Male), F (Female) or UN (Undifferentiated)."  
          } 
        end 
        # End patient gender
        
        # Start patient marital status
        if @patient_data.registration_information.marital_status
          xml.maritalStatusCode("code" => @patient_data.registration_information.marital_status.code, 
                                "displayName" => @patient_data.registration_information.marital_status.name, 
                                "codeSystemName" => "ASTM Maritial Status", 
                                "codeSystem" => "2.16.840.1.113883.3.88.6.1633.5.2.2")
        end
        # End patient gender
        
        # Start patient race
        if @patient_data.registration_information.race
          xml.maritalStatusCode("code" => @patient_data.registration_information.race.code, 
                                "displayName" => @patient_data.registration_information.race.name, 
                                "codeSystemName" => "CDC Race and Ethnicity", 
                                "codeSystem" => "2.16.840.1.113883.6.238")
        end
        # End patient race
        
        # End patient ethnicity
        if @patient_data.registration_information.ethnicity
          xml.maritalStatusCode("code" => @patient_data.registration_information.ethnicity.code, 
                                "displayName" => @patient_data.registration_information.ethnicity.name, 
                                "codeSystemName" => "CDC Race and Ethnicity", 
                                "codeSystem" => "2.16.840.1.113883.6.238")
        end
        # End patient ethnicity
        
        # Start patient religion
        if @patient_data.registration_information.religion
          xml.maritalStatusCode("code" => @patient_data.registration_information.religion.code, 
                                "displayName" => @patient_data.registration_information.religion.name, 
                                "codeSystemName" => "Religious Affiliation", 
                                "codeSystem" => "2.16.840.1.113883.5.1076")
        end
        # End patient religion
        
        # Start patient date of birth
        if @patient_data.registration_information.date_of_birth
          xml.birthTime("value" => @patient_data.registration_information.date_of_birth.strftime("%Y%m%d"))  
        end
        # End patient date of birth
        
        # Start patient languages
        if @patient_data.languages
          @patient_data.languages.each { |language|
            xml.languageCommunication {
              xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.2")
              xml.languageCode("code" => language.iso_language.code + "-" +language.iso_country.code,
                               "displayName" => language.iso_language.name) 
              if language.language_ability_mode &&
                 language.language_ability_mode.code
                xml.modeCode("code" => language.language_ability_mode.code, 
                             "displayName" => language.language_ability_mode.name,
                             "codeSystem" => "2.16.840.1.113883.5.60",
                             "codeSystemName" => "LanguageAbilityMode")
              end
              if language.preference != nil
                xml.preferenceInd("value" => language.preference)
              end
            }
          }
        end 
        # End patient languages
        
        # Start patient GUARD support
        if @patient_data.support.contact_type &&
           @patient_data.support.contact_type.code == "GUARD"
          xml.guardian("classCode" => @patient_data.support.contact_type.code) {
            xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.3")
            
            # Start patient GUARD relationship 
            if @patient_data.support.relationship
              xml.code("code" => @patient_data.support.relationship.code, 
                       "displayName" => @patient_data.support.relationship.name,
                       "codeSystem" => "2.16.840.1.113883.5.111",
                       "codeSystemName" => "RoleCode")
            end
            # End patient GUARD relationship
            
            # Start patient GUARD address 
            if @patient_data.support.address
              xml.addr {
               if @patient_data.support.address.street_address_line_one &&
                  @patient_data.support.address.street_address_line_one.size > 0
                 xml.streetAddressLine @patient_data.support.address.street_address_line_one
               end
               if @patient_data.support.address.street_address_line_two &&
                  @patient_data.support.address.street_address_line_two.size > 0
                 xml.streetAddressLine @patient_data.support.address.street_address_line_two
               end
               if @patient_data.support.address.city &&
                  @patient_data.support.address.city.size > 0
                 xml.city @patient_data.support.address.city
               end
               if @patient_data.support.address.state &&
                  @patient_data.support.address.state.size > 0
                 xml.state @patient_data.support.address.state
               end
               if @patient_data.support.address.postal_code &&
                  @patient_data.support.address.postal_code.size > 0
                 xml.postalCode @patient_data.support.address.postal_code
               end
               if @patient_data.support.address.iso_country 
                 xml.country @patient_data.support.address.iso_country.code
               end
             }
            end
            # End patient GUARD address 
            
            # Start patient GUARD telecom 
            if @patient_data.support.telecom 
              if @patient_data.support.telecom.home_phone && 
                 @patient_data.support.telecom.home_phone.size > 0
                xml.telecom("use" => "HP", "value" => @patient_data.support.telecom.home_phone)
              end
              if @patient_data.support.telecom.work_phone && 
                 @patient_data.support.telecom.work_phone.size > 0
                xml.telecom("use" => "WP", "value" => @patient_data.support.telecom.work_phone)
              end
              if @patient_data.support.telecom.mobile_phone && 
                 @patient_data.support.telecom.mobile_phone.size > 0
                xml.telecom("use" => "MC", "value" => @patient_data.support.telecom.mobile_phone)
              end
              if @patient_data.support.telecom.vacation_home_phone && 
                 @patient_data.support.telecom.vacation_home_phone.size > 0
                xml.telecom("use" => "HV", "value" => @patient_data.support.telecom.vacation_home_phone)
              end
              if @patient_data.support.telecom.email && 
                 @patient_data.support.telecom.email.size > 0
                xml.telecom("value" => "mailto:" + @patient_data.support.telecom.email)
              end
              if @patient_data.support.telecom.url && 
                 @patient_data.support.telecom.url.size > 0
                xml.telecom("value" => @patient_data.support.telecom.url)
              end
            end
            # Start patient GUARD telecom 
            
            # Start patient GUARD name 
            xml.guardianPerson {
              if @patient_data.support.person_name 
                xml.name {
                  if @patient_data.support.person_name.name_prefix &&
                     @patient_data.support.person_name.name_prefix.size > 0
                    xml.prefix @patient_data.support.person_name.name_prefix
                  end
                  if @patient_data.support.person_name.first_name &&
                     @patient_data.support.person_name.first_name.size > 0
                    xml.given(@patient_data.support.person_name.first_name, "qualifier" => "CL")
                  end
                  if @patient_data.support.person_name.last_name &&
                     @patient_data.support.person_name.last_name.size > 0
                    xml.family (@patient_data.support.person_name.last_name, "qualifier" => "BR")
                  end
                  if @patient_data.support.person_name.name_suffix &&
                     @patient_data.support.person_name.name_suffix.size > 0
                    xml.prefix @patient_data.support.person_name.name_suffix
                  end
                }
              end 
            }
            # End patient GUARD name 
          }
        end 
        # End patient GUARD support 
        
      }
      # End patient
      
      # Start non-GUARD support type
      if @patient_data.support.contact_type &&
         @patient_data.support.contact_type.code != "GUARD"
        xml.participant("typeCode" => "IND") {
          xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.3")
          xml.associatedEntity("classCode" => @patient_data.support.contact_type.code) {
            
            # Start patient non-GUARD relationship 
            xml.code("code" => @patient_data.support.relationship.code, 
                     "displayName" => @patient_data.support.relationship.name,
                     "codeSystem" => "2.16.840.1.113883.5.111",
                     "codeSystemName" => "RoleCode")
            # End patient non-GUARD relationship 
                     
            # Start non-GUARD support address         
            if @patient_data.support.address
              xml.addr {
                if @patient_data.support.address.street_address_line_one &&
                   @patient_data.support.address.street_address_line_one.size > 0
                  xml.streetAddressLine @patient_data.support.address.street_address_line_one
                end
                if @patient_data.support.address.street_address_line_two &&
                   @patient_data.support.address.street_address_line_two.size > 0
                  xml.streetAddressLine @patient_data.support.address.street_address_line_two
                end
                if @patient_data.support.address.city &&
                   @patient_data.support.address.city.size > 0
                  xml.city @patient_data.support.address.city
                end
                if @patient_data.support.address.state &&
                   @patient_data.support.address.state.size > 0
                  xml.state @patient_data.support.address.state
                end
                if @patient_data.support.address.postal_code &&
                   @patient_data.support.address.postal_code.size > 0
                  xml.postalCode @patient_data.support.address.postal_code
                end
                if @patient_data.support.address.iso_country 
                  xml.country @patient_data.support.address.iso_country.code
                end
              }
            end
            # End non-GUARD support address   
              
            # Start non-GUARD support telecom    
            if @patient_data.support.telecom 
              if @patient_data.support.telecom.home_phone && 
                 @patient_data.support.telecom.home_phone.size > 0
                xml.telecom("use" => "HP", "value" => @patient_data.support.telecom.home_phone)
              end
              if @patient_data.support.telecom.work_phone && 
                 @patient_data.support.telecom.work_phone.size > 0
                xml.telecom("use" => "WP", "value" => @patient_data.support.telecom.work_phone)
              end
              if @patient_data.support.telecom.mobile_phone && 
                 @patient_data.support.telecom.mobile_phone.size > 0
                xml.telecom("use" => "MC", "value" => @patient_data.support.telecom.mobile_phone)
              end
              if @patient_data.support.telecom.vacation_home_phone && 
                 @patient_data.support.telecom.vacation_home_phone.size > 0
                xml.telecom("use" => "HV", "value" => @patient_data.support.telecom.vacation_home_phone)
              end
              if @patient_data.support.telecom.email && 
                 @patient_data.support.telecom.email.size > 0
                xml.telecom("value" => "mailto:" + @patient_data.support.telecom.email)
              end
              if @patient_data.support.telecom.url && 
                 @patient_data.support.telecom.url.size > 0
                xml.telecom("value" => @patient_data.support.telcom.url)
              end
            end
            # End non-GUARD support telecom    
            
            # Start non-GUARD support assigned person    
            xml.assignedPerson {
              if @patient_data.support.person_name 
                xml.name {
                  if @patient_data.support.person_name.name_prefix &&
                     @patient_data.support.person_name.name_prefix.size > 0
                    xml.prefix @patient_data.support.person_name.name_prefix
                  end
                  if @patient_data.support.person_name.first_name &&
                     @patient_data.support.person_name.first_name.size > 0
                    xml.given(@patient_data.support.person_name.first_name, "qualifier" => "CL")
                  end
                  if @patient_data.support.person_name.last_name &&
                     @patient_data.support.person_name.last_name.size > 0
                    xml.family (@patient_data.support.person_name.last_name, "qualifier" => "BR")
                  end
                  if @patient_data.support.person_name.name_suffix &&
                     @patient_data.support.person_name.name_suffix.size > 0
                    xml.prefix @patient_data.support.person_name.name_suffix
                  end
                }
              end
            }
            # End non-GUARD support assigned person     
          }
        }
      end
      # End non-GUARD support types
    end
  }
}