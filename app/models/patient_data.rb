class PatientData < ActiveRecord::Base
  has_one    :registration_information
  has_many   :languages
  has_many   :providers
  has_many   :medications
  has_one    :support
  has_many   :allergies
  has_many   :conditions
  has_one    :information_source
  has_one    :advance_directive
  has_many   :comments
  belongs_to :vendor_test_plan
  belongs_to :user
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def validate_c32(clinical_document)
    errors = self.registration_information.validate_c32(clinical_document)
    errors
  end
  
  def copy
    copied_patient_data = self.clone
    copied_patient_data.save!
    
    if self.registration_information
      copied_patient_data.registration_information = self.registration_information.copy
      # TODO: Copying the children on registration info should be moved into the RegistrationInformation class
      copied_patient_data.registration_information.race = self.registration_information.race
      copied_patient_data.registration_information.ethnicity = self.registration_information.ethnicity
      copied_patient_data.registration_information.marital_status = self.registration_information.marital_status
      copied_patient_data.registration_information.gender = self.registration_information.gender
      copied_patient_data.registration_information.religion = self.registration_information.religion
    end
    

    self.languages.each do |language|
      copied_language = language.clone
      copied_language.patient_data = copied_patient_data
      copied_language.save!
    end
    
    copied_patient_data.support = self.support.copy if self.support
    
    self.providers.each do |provider|
      copied_patient_data.providers << provider.copy
    end
    
    self.medications.each do |medication|
      copied_patient_data.medications << medication.clone
    end
    
    self.allergies.each do |allergy|
      copied_patient_data.allergies << allergy.clone
    end
    
    self.conditions.each do |condition|
      copied_patient_data.conditions << condition.clone
    end
    
    copied_patient_data.information_source = self.information_source.copy if self.information_source
    
    self.comments.each do |comment|
      copied_patient_data.comments << comment.copy
    end
    
    copied_patient_data.advance_directive = self.advance_directive.copy if self.advance_directive
    
    copied_patient_data
  end
  
  
  def to_c32(xml = Builder::XmlMarkup.new)
      
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
      xml.title(name)
      xml.effectiveTime("value" => updated_at.strftime("%Y%m%d%H%M%S-0500"))
      xml.confidentialityCode
      xml.languageCode("code" => "en-US")
      xml.recordTarget {
        xml.patientRole {
          xml.id("extension" => "24602", 
                 "root" => "SomeClinicalOrganizationOID", 
                 "assigningAuthorityName" => "Some Clinical Organization Name") 
            registration_information.andand.to_c32(xml)
            
        }   
      }
      information_source.andand.to_c32(xml)
      xml.custodian{
         xml.assignedCustodian{
                 xml.representedCustodianOrganization{
                     xml.id
                 }
         }
          
      }
      if support && support.contact_type && support.contact_type.code != "GUARD" 
        support.to_c32(xml)
      end          
        
      providers.andand.each do |provider|
                    provider.to_c32(xml)
      end      
         
        
      xml.component {
        xml.structuredBody {
        
          # Start Pregnancy
          if (pregnant != nil && pregnant == true)   
            xml.component {
              xml.section {
                xml.title "Results"
                xml.text "Patient is currently pregnant"
                xml.entry {
                  xml.observation ("classCode" => "OBS", "moodCode" => "EVN") {
                    xml.value ("xsi:type" => "CD", 
                               "code" => "77386006", 
                               "displayName" => "Patient currently pregnant", 
                               "codeSystem" => "2.16.840.1.113883.6.96", 
                               "codeSystemName" => "SNOMED CT") {} 
                  }
                }
              }               
            }
          end
          # End Pregnancy
          
          # Start Conditions
          if conditions.size > 0
            xml.component {
              xml.section {
                xml.templateId("root" => "2.16.840.1.113883.10.20.1.11", 
                               "assigningAuthorityName" => "CCD")
                xml.code("code" => "11450-4", 
                         "displayName" => "Problems", 
                         "codeSystem" => "2.16.840.1.113883.6.1", 
                         "codeSystemName" => "LOINC")
                xml.title "Conditions or Problems"
                xml.text {
                  conditions.andand.each do |condition|
                  xml.paragraph (condition.free_text_name,"ID" => "problem-"+condition.id.to_s) 
                  end
                }
                
                # Start structured XML
                conditions.andand.each do |structuredCondition|
                  structuredCondition.to_c32(xml)
                end
                # End structured XML
              }
            }
          end
          # End Conditions
          
          # Start Allergies
          if allergies.size > 0
            xml.component {
              xml.section {
                xml.templateId("root" => "2.16.840.1.113883.10.20.1.2", 
                               "assigningAuthorityName" => "CCD")
                xml.code("code" => "48765-2", 
                         "codeSystem" => "2.16.840.1.113883.6.1")
                xml.title "Allergies, Adverse Reactions, Alerts"
                xml.text {
                  xml.table("border" => "1", "width" => "100%") {
                    xml.thead {
                      xml.tr {
                        xml.th "Substance"
                        xml.th "Event Type"
                        xml.th "Severity"
                      }
                    }
                    xml.tbody {
                      allergies.andand.each do |allergy|
                        xml.tr {
                          if allergy.free_text_product != nil
                            xml.td allergy.free_text_product
                          else
                            xml.td
                          end 
                          if allergy.adverse_event_type != nil
                            xml.td allergy.adverse_event_type.name
                          else
                            xml.td
                          end  
                          if allergy.severity_term != nil
                            xml.td {
                              xml.content("ID" => "severity-" + allergy.id.to_s) {
                                allergy.severity_term.name
                              }
                            }
                          else
                            xml.td
                          end  
                        }
                      end
                    }
                  }
                }
                
                # Start structured XML
                allergies.andand.each do |structuredAllergy|
                  structuredAllergy.to_c32(xml)
                end
                # End structured XML
              }
            }
          end
          # End Allergies
          
          # Start Medications
          if medications.size > 0
            xml.component {
              xml.section {
                xml.templateId("root" => "2.16.840.1.113883.10.20.1.8", 
                               "assigningAuthorityName" => "CCD")
                xml.code("code" => "10160-0", 
                         "displayName" => "History of medication use", 
                         "codeSystem" => "2.16.840.1.113883.6.1", 
                         "codeSystemName" => "LOINC")
                xml.title "Medications"
                xml.text {
                  medications.andand.each do |medication|
                    xml.content("ID" => "medication-"+medication.id.to_s) {
                      medication.product_coded_display_name
                    }
                  end
                }
                
                # Start structured XML
                medications.andand.each do |structuredMedication|
                  structuredMedication.to_c32(xml)
                end
                # End structured XML
              }
            }
          end
          # End Medications 
          
          # Start Advanced Directive
          if advance_directive
            xml.component {
              xml.section {
                xml.templateId("root" => "2.16.840.1.113883.10.20.1.1")
                xml.code("code" => "42348-3", 
                         "codeSystem" => "2.16.840.1.113883.6.1", 
                         "codeSystemName" => "LOINC")
                xml.title "Advance Directive"
                xml.text {
                  xml.content("ID" => "advance-directive-" + advance_directive.id.to_s) {
                    advance_directive.free_text
                  }
                }
                
                # Start structured XML
                advance_directive.to_c32(xml)
                # End structured XML
              }
            }
          end
          # End Advanced Directive
          
        }                   
      }
    }      
  end  
  
end
