class Support < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  belongs_to :contact_type
  belongs_to :relationship
  include PersonLike
  include MatchHelper
  
  def validate_c32(xml)
    errors = []
    support = REXML::XPath.first(xml, "/cda:ClinicalDocument/cda:participant/cda:associatedEntity[cda:associatedPerson/cda:name/text() = $name ] | /cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:guardian[cda:guardianPerson/cda:name/text() = $name]",
        {'cda' => 'urn:hl7-org:v3'}, {"name" => name})
    if support
      time_element = REXML::XPath.first(support, "../cda:time", {'cda' => 'urn:hl7-org:v3'})
      if time_element
        if self.start_support
          errors << match_value(time_element, "cda:low/@value", "start_support", self.start_support.to_formatted_s(:hl7_ts))
        end
        if self.end_support
          errors << match_value(time_element, "cda:high/@value", "end_support", self.end_support.to_formatted_s(:hl7_ts))
        end
      else
        errors <<  ContentError.new(:section => "Support", 
                            :subsection => "date",
                            :error_message => "No time element found in the support",
                            :location => support.xpath)
      end
      if self.address
        add =  REXML::XPath.first(support,"cda:addr",{'cda' => 'urn:hl7-org:v3'})
        if add
           errors.concat   self.address.validate_c32(add)  
        else                                 
           errors <<  ContentError.new(:section => "Support", 
                               :subsection => "address",
                               :error_message => "Address not found in the support section #{support.xpath}",
                               :location => support.xpath)          

        end
      end

      if self.telecom
          errors.concat self.telecom.validate_c32(support)
      end

     # classcode
    errors << match_value(support, "@classCode", "contact_type", contact_type.andand.code)

    errors << match_value(support, "cda:code[@codeSystem='2.16.840.1.113883.5.111']/@code", "relationship", relationship.andand.code)

    else
       # add the error for no support object being there 
        errors <<  ContentError.new(:section=> "Support", 
                                    :error_message=> "Support element does not exist")          
    end
    
    errors.compact
    
  end
  
  def name
    self.person_name.first_name + ' ' + self.person_name.last_name
  end
  
  def to_c32(xml)
    if contact_type &&
       contact_type.code == "GUARD"
      xml.guardian("classCode" => contact_type.code) {
        xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.3")
        if relationship
          xml.code("code" => relationship.code, 
                   "displayName" => relationship.name,
                   "codeSystem" => "2.16.840.1.113883.5.111",
                   "codeSystemName" => "RoleCode")
        end
        address.andand.to_c32(xml)
        telecom.andand.to_c32(xml)
        xml.guardianPerson {
          person_name.to_c32(xml)
        }
      }
    else
      xml.participant("typeCode" => "IND") {
        xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.3")

        xml.time{
                    if start_support 
                              xml.low('value'=> start_support.strftime("%Y%m%d"))
                            end
                            if end_support
                              xml.high('value'=> end_support.strftime("%Y%m%d"))
                  end
                }      

        xml.associatedEntity("classCode" => contact_type.code) {
          xml.code("code" => relationship.code, 
               "displayName" => relationship.name,
               "codeSystem" => "2.16.840.1.113883.5.111",
               "codeSystemName" => "RoleCode")
          address.andand.to_c32(xml)
          telecom.andand.to_c32(xml) 
          xml.associatedPerson {
            person_name.andand.to_c32(xml)
          }
        }
      }
    end            
    
  end
 
end
