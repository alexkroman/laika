class PersonName < ActiveRecord::Base
  belongs_to :nameable, :polymorphic => true
  
  # Checks the contents of the REXML::Element passed in to make sure that they match the
  # information in this object. This method expects the the element passed in to be the
  # name element that it will evaluate.
  # Will return an empty array if everything passes. Otherwise,
  # it will return an array of ContentErrors with a description of what's wrong.
  def validate_c32(name_element)
    errors = []
    errors << XmlHelper.match_value(name_element, 'cda:prefix', self.name_prefix)
    errors << XmlHelper.match_value(name_element, 'cda:given', self.first_name)
    errors << XmlHelper.match_value(name_element, 'cda:family', self.last_name)
    errors << XmlHelper.match_value(name_element, 'cda:suffix', self.name_suffix)
    errors.compact
  end
end
