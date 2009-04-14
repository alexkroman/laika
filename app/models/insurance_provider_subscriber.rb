class InsuranceProviderSubscriber < ActiveRecord::Base

  strip_attributes!

  include InsuranceProviderChild

  include PersonLike

  def to_c32(xml)
    xml.participant("typeCode" => "HLD") do
      xml.participantRole("classCode" => "IND") do
        xml.id('root'=>'AssignAuthorityGUID', 'extension'=>subscriber_id)
        address.andand.to_c32(xml)
        telecom.andand.to_c32(xml)
        xml.playingEntity do
            person_name.andand.to_c32(xml)
          if !date_of_birth.blank?
             xml.sdtc(:birthTime, "value" => date_of_birth.strftime("%Y%m%d"))
          end
        end
      end
    end
  end

  def randomize()
    self.person_name = PersonName.new
    self.address = Address.new
    self.telecom = Telecom.new

    self.person_name.first_name = Faker::Name.first_name
    self.person_name.last_name = Faker::Name.last_name
    self.address.randomize()
    self.telecom.randomize()
  end
 
end
