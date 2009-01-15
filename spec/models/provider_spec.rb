require File.dirname(__FILE__) + '/../spec_helper'

describe Provider, "can validate itself" do
  fixtures :providers,:provider_roles,:provider_types, :person_names
  
  before(:each) do
    @provider = providers(:rn_mary_smith)
  end  
  
  it "should validate without errors" do
      document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/jenny_healthcare_provider.xml'))
      errors = @provider.validate_c32(document.root)
      #puts errors.map { |e| e.error_message }.join(' ')
      errors.should be_empty
      
  end 
  
end

describe Provider, "can create a C32 representation of itself" do
  fixtures :providers,:provider_roles,:provider_types, :person_names, :telecoms, :addresses
  
  it "should create valid C32 content" do
    provider = providers(:rn_mary_smith)
    document = LaikaSpecHelper.build_c32 do |xml|
        xml.documentationOf do 
            xml.serviceEvent("classCode" => "PCPR") do 
              xml.effectiveTime  do
                 xml.low('value'=> "0")
                 xml.high('value'=> "2010")
              end     
            provider.to_c32(xml)
            end 
        end

    end

    errors = provider.validate_c32(document.root)
    errors.should be_empty
  end
end
