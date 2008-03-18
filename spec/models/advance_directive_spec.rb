require File.dirname(__FILE__) + '/../spec_helper'

describe AdvanceDirective, "can validate itself" do
  fixtures :advance_directives, :advance_directive_types
  
  before(:each) do
    @ad = advance_directives(:jennifer_thompson_advance_directive)
  end  
  
  it "should validate without errors" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/advance_directive/jenny_advance_directive.xml'))
    errors = @ad.validate_c32(document.root)
    errors.should be_empty
  end 
end

describe AdvanceDirective, "can create a C32 representation of itself" do
  fixtures :advance_directives, :advance_directive_types

  it "should create valid C32 content" do
    ad = advance_directives(:jennifer_thompson_advance_directive)
    
    buffer = ""
    xml = Builder::XmlMarkup.new(:target => buffer)
    xml.ClinicalDocument("xsi:schemaLocation" => "urn:hl7-org:v3 http://xreg2.nist.gov:8080/hitspValidation/schema/cdar2c32/infrastructure/cda/C32_CDA.xsd", 
                         "xmlns" => "urn:hl7-org:v3", 
                         "xmlns:sdct" => "urn:hl7-org:sdct", 
                         "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance") do
                           
      xml.component do
        xml.structuredBody do
          xml.component do
            xml.section do
              xml.templateId("root" => "2.16.840.1.113883.10.20.1.1")
              xml.code("code" => "42348-3", 
                       "codeSystem" => "2.16.840.1.113883.6.1", 
                       "codeSystemName" => "LOINC")
              xml.title "Advance Directive"
              xml.text do
                xml.content("ID" => "advance-directive-" + ad.id.to_s) do
                  ad.free_text
                end
              end
              ad.to_c32(xml)
            end
          end
        end
      end
    end
    puts buffer
    document = REXML::Document.new(StringIO.new(buffer))
    errors = ad.validate_c32(document.root)
    puts errors.map { |e| e.error_message }.join(' ')
    errors.should be_empty
  end
end