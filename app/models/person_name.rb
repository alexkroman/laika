class PersonName < ActiveRecord::Base
  strip_attributes!

  belongs_to :nameable, :polymorphic => true
  
  # Checks the contents of the REXML::Element passed in to make sure that they match the
  # information in this object. This method expects the the element passed in to be the
  # name element that it will evaluate.
  # Will return an empty array if everything passes. Otherwise,
  # it will return an array of ContentErrors with a description of what's wrong.
  def validate_c32(name_element)
    
    errors = []
    if name_element
    errors << match_value(name_element, 'cda:prefix', self.name_prefix)
    errors << match_value(name_element, 'cda:given', self.first_name)
    errors << match_value(name_element, 'cda:family', self.last_name)
    errors << match_value(name_element, 'cda:suffix', self.name_suffix)
    else
        errors << ContentError.new(:section => self.nameable_type.underscore, 
        :error_message => "name element was null",:location=>name_element ? name_element.xpath : nil)
    end
    errors.compact
  end
  
  private
  
  def match_value(name_element, xpath, value)
    error = XmlHelper.match_value(name_element, xpath, value)
    if error
      return ContentError.new(:section => self.nameable_type.underscore, :subsection => 'telecom',
          :error_message => error,:location=>name_element ? name_element.xpath : nil)
    else
      return nil
    end
  end
end
