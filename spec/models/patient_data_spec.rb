require File.dirname(__FILE__) + '/../spec_helper'

describe PatientData do
  fixtures :patient_data, :registration_information, :person_names, :addresses, :telecoms, :genders

  before { @patient_data = patient_data(:joe_smith) }

  it "should require a name" do
    @patient_data.name = ''
    @patient_data.should_not be_valid
  end

  it "should create a C32 representation of itself" do
    buffer = ""
    xml = Builder::XmlMarkup.new(:target => buffer, :indent => 2)
    @patient_data.to_c32(xml)
    document = REXML::Document.new(StringIO.new(buffer))
    errors = @patient_data.validate_c32(document.root)
    #puts errors.map { |e| e.error_message }.join(' ')
    errors.should be_empty
  end

  describe "copied with .copy()" do
  
    before { @patient_data_copy = @patient_data.copy }
  
    it "should have the same name as its source" do
      @patient_data_copy.name.should == @patient_data.name
    end
    
    it "should have the same registration information as its source" do
      @patient_data_copy.registration_information.should_not be_nil
      @patient_data_copy.registration_information.gender.code.should ==
        @patient_data.registration_information.gender.code
      @patient_data_copy.registration_information.person_name.first_name.should ==
        @patient_data.registration_information.person_name.first_name
      @patient_data_copy.registration_information.person_name.last_name.should ==
        @patient_data.registration_information.person_name.last_name
    end
  end
end

