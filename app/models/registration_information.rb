class RegistrationInformation < ActiveRecord::Base

  strip_attributes!

  belongs_to :patient_data
  belongs_to :race
  belongs_to :ethnicity
  belongs_to :marital_status
  belongs_to :gender
  belongs_to :religion

  include PersonLike


  def requirements
    {
      :document_timestamp => :required,
      :person_identifier => :required,
      :gender_id => :required,
      :date_of_birth => :required,
      :marital_status_id => :hitsp_r2_optional,
    }
  end

 

  def to_c32(xml = Builder::XmlMarkup.new)

    xml.id("extension" => person_identifier)

    address.andand.to_c32(xml)
    telecom.andand.to_c32(xml)

    xml.patient do
      person_name.andand.to_c32(xml)
      gender.andand.to_c32(xml)
      if date_of_birth
        xml.birthTime("value" => date_of_birth.strftime("%Y%m%d"))  
      end

      marital_status.andand.to_c32(xml)
      religion.andand.to_c32(xml)
      race.andand.to_c32(xml)
      ethnicity.andand.to_c32(xml)

      # do the gaurdian stuff here non gaurdian is placed elsewhere
      if patient_data.support &&
         patient_data.support.contact_type &&
         patient_data.support.contact_type.code == "GUARD"
        patient_data.support.to_c32(xml)
      end  

      patient_data.languages.to_c32(xml)

    end

  end

  def randomize(patient)

    self.person_identifier = "1234567890"
    self.document_timestamp = DateTime.new(2000 + rand(8), rand(12) + 1, rand(28) + 1)

    self.person_name = patient
    self.gender = Gender.find(:all).sort_by{rand}.first
    self.race = Race.find(:all).sort_by{rand}.first
    self.ethnicity = Ethnicity.find(:all).sort_by{rand}.first
    self.religion = Religion.find(:all).sort_by{rand}.first
    self.marital_status = MaritalStatus.find(:all).sort_by{rand}.first
    self.date_of_birth = DateTime.new(1930 + rand(78), rand(12) + 1, rand(28) + 1)

    self.address = Address.new
    self.address.randomize()

    self.telecom = Telecom.new
    self.telecom.randomize()

  end

end
