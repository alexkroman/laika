require File.dirname(__FILE__) + '/../spec_helper'

describe PatientData, "can copy itself" do
  fixtures :patient_data, :registration_information, :person_names, :addresses,
           :genders
  
  before(:each) do
    @patient_data = patient_data(:joe_smith)
    @patient_data_copy = @patient_data.copy
  end

  it "should copy its name when copied" do
    @patient_data_copy.name.should == 'Joe Smith'
  end
  
  it "should copy its registration information" do
    @patient_data_copy.registration_information.should_not be_nil
    @patient_data_copy.registration_information.gender.code.should == 'M'
    @patient_data_copy.registration_information.person_name.first_name.should == 'Joe'
    @patient_data_copy.registration_information.person_name.last_name.should == 'Smith'
  end
end

describe PatientData, "can create a C32 representation of itself" do
  fixtures :patient_data, :registration_information, :person_names, :addresses, :telecoms, :genders
  
  it "should create valid C32 content" do
    patient_data = patient_data(:joe_smith)
    
    buffer = ""
    xml = Builder::XmlMarkup.new(:target => buffer, :indent => 2)
    patient_data.to_c32(xml)
    document = REXML::Document.new(StringIO.new(buffer))
    errors = patient_data.validate_c32(document.root)
    puts errors.map { |e| e.error_message }.join(' ')
    errors.should be_empty
  end
end
