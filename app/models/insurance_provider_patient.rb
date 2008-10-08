class InsuranceProviderPatient < ActiveRecord::Base

  strip_attributes!

  belongs_to :insurance_provider

  include PersonLike
  include MatchHelper

  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}

  def validate_c32(document)

  end

  def to_c32(xml)

  end

  def randomize(reg_info)
    self.person_name = PersonName.new
    self.address = Address.new
    self.telecom = Telecom.new

    self.person_name.first_name = reg_info.person_name.first_name
    self.person_name.last_name = reg_info.person_name.last_name
    self.address.street_address_line_one = reg_info.address.street_address_line_one
    self.address.city = reg_info.address.city
    self.address.state = reg_info.address.state
    self.address.postal_code = reg_info.address.postal_code
    self.address.iso_country = reg_info.address.iso_country
    self.member_id = random_id()

    self.telecom.home_phone = reg_info.telecom.home_phone
    self.telecom.work_phone = reg_info.telecom.work_phone
    self.telecom.mobile_phone = reg_info.telecom.work_phone
    self.date_of_birth = reg_info.date_of_birth()

    self.start_coverage_date = DateTime.new(reg_info.date_of_birth.year + rand(DateTime.now.year - reg_info.date_of_birth.year),
                       rand(12) + 1, rand(28) + 1)
    self.end_coverage_date = DateTime.new(self.start_coverage_date.year + rand(DateTime.now.year - self.start_coverage_date.year),
                       rand(12) + 1, rand(28) + 1)
  end

protected

  def random_char()
    char = ('A'..'Z').to_a
    char[rand(24)]
  end

  def random_id()
    random_char() + random_char() + random_char() + (1000 + rand(8999)).to_s + random_char() + (10000 + rand(89999)).to_s
  end
 
end
