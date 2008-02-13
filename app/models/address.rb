class Address < ActiveRecord::Base
  belongs_to :iso_country
  belongs_to :addressable, :polymorphic => true
  
  # Checks the contents of the REXML::Element passed in to make sure that they match the
  # information in this object. This method expects the the element passed in to be the
  # address element that it will evaluate.
  # Will return an empty array if everything passes. Otherwise,
  # it will return an array of ContentErrors with a description of what's wrong.
  def validate_c32(address_element)
    errors = []
    errors << XmlHelper.match_value(address_element, 'cda:streetAddressLine[1]', self.street_address_line_one)
    errors << XmlHelper.match_value(address_element, 'cda:streetAddressLine[2]', self.street_address_line_two)
    errors << XmlHelper.match_value(address_element, 'cda:city', self.city)
    errors << XmlHelper.match_value(address_element, 'cda:state', self.state)
    errors << XmlHelper.match_value(address_element, 'cda:postalCode', self.postal_code)
    if self.iso_country
      errors << XmlHelper.match_value(address_element, 'cda:country', self.iso_country.code)
    end
    errors.compact
  end
end
