class InsuranceProviderSubscriber < ActiveRecord::Base

  strip_attributes!

  belongs_to :insurance_provider

  include PersonLike
  include MatchHelper

  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}

  def validate_c32(act)

    unless act
      return [ContentError.new]
    end

    errors = []

    begin
      particpantRole = REXML::XPath.first(act,"cda:participant[@typeCode='HLD']/cda:participantRole[@classCode='IND']",@@default_namespaces)
      if person_name
        errors.concat person_name.validate_c32(REXML::XPath.first(particpantRole,"cda:playingEntity/cda:name",@@default_namespaces))
      end       
      if address
        errors.concat address.validate_c32(REXML::XPath.first(particpantRole,'cda:addr',@@default_namespaces))
      end
      if telecom
        errors.concat telecom.validate_c32(REXML::XPath.first(particpantRole,'cda:telecom',@@default_namespaces))
      end
    rescue
      errors << ContentError.new(
              :section => 'Subscriber Information', 
              :error_message => 'Failed checking name, address and telecom details on the insurance provider subcriber XML',
              :type=>'error',
              :location => act.xpath)
    end

    return errors.compact
  end

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
