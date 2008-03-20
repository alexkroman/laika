require File.dirname(__FILE__) + '/../spec_helper'

describe Allergy, "it can validate allergy entries in a C32" do
  fixtures :allergies, :severity_terms, :adverse_event_types
  
  it "should verify an allergy matches in a C32 doc" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/allergies/joe_allergy.xml'))
    joe_allergy = allergies(:joes_allergy)
    errors = joe_allergy.validate_c32(document)
    errors.should be_empty
  end
  
  it "should verify when there are no known allergies" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/allergies/no_known_allergies.xml'))
    allergy = Allergy.new
    errors = allergy.check_no_known_allergies_c32(document)
    errors.should be_empty
  end
end

describe Allergy, "can create a C32 representation of itself" do
  fixtures :allergies, :severity_terms, :adverse_event_types
  
  it "should create valid C32 content" do
    joe_allergy = allergies(:joes_allergy)
    
    buffer = ""
    xml = Builder::XmlMarkup.new(:target => buffer, :indent => 2)
    xml.ClinicalDocument("xsi:schemaLocation" => "urn:hl7-org:v3 http://xreg2.nist.gov:8080/hitspValidation/schema/cdar2c32/infrastructure/cda/C32_CDA.xsd", 
                         "xmlns" => "urn:hl7-org:v3", 
                         "xmlns:sdct" => "urn:hl7-org:sdct", 
                         "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance") do
       xml.component do
         xml.structuredBody do
             xml.component do
               xml.section do
                 xml.templateId("root" => "2.16.840.1.113883.10.20.1.2", 
                                "assigningAuthorityName" => "CCD")
                 xml.code("code" => "48765-2", 
                          "codeSystem" => "2.16.840.1.113883.6.1")
                 xml.title "Allergies, Adverse Reactions, Alerts"
                 xml.text do
                   xml.table("border" => "1", "width" => "100%") do
                     xml.thead do
                       xml.tr do
                         xml.th "Substance"
                         xml.th "Event Type"
                         xml.th "Severity"
                       end
                     end
                     xml.tbody do
                       xml.tr do
                         if joe_allergy.free_text_product != nil
                           xml.td joe_allergy.free_text_product
                         else
                           xml.td
                         end 
                         if joe_allergy.adverse_event_type != nil
                           xml.td joe_allergy.adverse_event_type.name
                         else
                           xml.td
                         end  
                         if joe_allergy.severity_term != nil
                           xml.td do
                             xml.content(joe_allergy.severity_term.name, 
                                         "ID" => "severity-" + joe_allergy.id.to_s)
                           end
                         else
                           xml.td
                         end  
                       end

                     end
                   end
                 end

                 # Start structured XML
                 joe_allergy.to_c32(xml)
                 # End structured XML
               end
             end
         end
           
       end
    end
    document = REXML::Document.new(StringIO.new(buffer))
    puts buffer
    errors = joe_allergy.validate_c32(document.root)
    puts errors.map { |e| e.error_message }.join(' ')
    errors.should be_empty
  end
end