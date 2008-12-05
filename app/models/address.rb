class Address < ActiveRecord::Base

  strip_attributes!

  belongs_to :iso_country
  belongs_to :iso_state
  belongs_to :zip_code
  belongs_to :addressable, :polymorphic => true

  include MatchHelper
  
  def requirements
    case addressable_type
      when 'RegistrationInformation':
        {
          :street_address_line_one => :required,
          :city => :required,
          :state => :required,
          :postal_code => :required,
          :iso_country_id => :required,
        }
      when 'Support', 'Provider', 'Encounter':
        {
          :street_address_line_one => :hitsp_r2_optional,
          :city => :hitsp_r2_optional,
          :state => :hitsp_r2_required,
          :postal_code => :hitsp_r2_optional,
          :iso_country_id => :hitsp_r2_required,
        }
      when 'InsuranceProviderSubscriber':
        {
          :state => :required,
          :iso_country_id => :required,
        } 
      when 'InsuranceProviderPatient':
        {
          :street_address_line_one => :hitsp_r2_optional,
          :city => :hitsp_r2_optional,
          :state => :hitsp_r2_optional,
          :postal_code => :hitsp_r2_optional,
          :iso_country_id => :hitsp_r2_optional,
        }
      when 'InsuranceProviderGuarantor':
        {
          :state => :required,
          :iso_country_id => :required,
        }
      when 'AdvanceDirective':
        {
          :street_address_line_one => :hitsp_r2_optional,
          :city => :hitsp_r2_optional,
          :state => :hitsp_r2_optional,
          :postal_code => :hitsp_r2_optional,
          :iso_country_id => :hitsp_r2_optional,
        }
    end
  end

  # Checks the contents of the REXML::Element passed in to make sure that they match the
  # information in this object. This method expects the the element passed in to be the
  # address element that it will evaluate.
  # Will return an empty array if everything passes. Otherwise,
  # it will return an array of ContentErrors with a description of what's wrong.
  def validate_c32(address_element)
    errors = []
    if address_element
      errors << match_value(address_element, 'cda:streetAddressLine[1]', 'street_address_line_one', self.street_address_line_one)
      errors << match_value(address_element, 'cda:streetAddressLine[2]', 'street_address_line_two', self.street_address_line_two)
      errors << match_value(address_element, 'cda:city', 'city', self.city)
      errors << match_value(address_element, 'cda:state', 'state', self.state)
      errors << match_value(address_element, 'cda:postalCode', 'postal_code', self.postal_code)
      if self.iso_country
        errors << match_value(address_element, 'cda:country', 'country', self.iso_country.code)
      end
    else
       errors << ContentError.new(:section => self.addressable_type.underscore, 
                                  :subsection => 'address',
                                  :error_message => 'Address element is nil')
    end
    errors.compact
  end

  #Reimplementing from MatchHelper
  def section_name
    self.addressable_type.underscore
  end

  #Reimplementing from MatchHelper  
  def subsection_name
    'address'
  end

  def to_c32(xml = XML::Builder.new)
    xml.addr do
      if street_address_line_one && street_address_line_one.size > 0
        xml.streetAddressLine street_address_line_one
      end
      if street_address_line_two && street_address_line_two.size > 0
        xml.streetAddressLine street_address_line_two
      end
      if city && city.size > 0
        xml.city city
      end
      if state && state.size > 0
        xml.state state
      end
      if postal_code && postal_code.size > 0
        xml.postalCode postal_code
      end
      if iso_country 
        xml.country iso_country.code
      end
    end
  end

  def randomize()
    offset = rand(ZipCode.count)
    zip = ZipCode.find(:all, :limit => 1, :offset => offset).first
    self.street_address_line_one = Faker::Address.street_address
    self.city = zip.town
    self.state = zip.state
    self.postal_code = zip.zip
    self.iso_country = IsoCountry.find(1004581944) #sets the country as the USA
  end

end
