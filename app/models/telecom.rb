require 'faker'

# Encapsulates the telecom section of a C32. Instead of having
# a bunch of telecom instances as part of a has_many, we've
# rolled the common ones into a single record. This should
# make validation easier when dealing with phone numbers
# vs. email addresses
class Telecom < ActiveRecord::Base

  strip_attributes!

  # AG: did you expect telecomable? ;-)
  # RM: yes... yes I did...
  belongs_to :reachable, :polymorphic => true

  # Expects an REXML::Element which it can query for telecom elements a direct childeren.
  # This method will try to find all of the telecom for any of the attributes that it has
  # which are non-nil
  # If all telecoms are found, or no attributes are set, this will return an empty array.
  # Otherwise, the array will contain ContentErrors explaining what went wrong.
  def validate_c32(telecom_root)
    errors = []
    telecom_elements = REXML::XPath.match(telecom_root, 'cda:telecom', {'cda' => 'urn:hl7-org:v3'})
    errors << validate_individual_telecom('HP', self.home_phone, telecom_elements)
    errors << validate_individual_telecom('WP', self.work_phone, telecom_elements)
    errors << validate_individual_telecom('MC', self.mobile_phone, telecom_elements)
    errors << validate_individual_telecom('HV', self.vacation_home_phone, telecom_elements)
    errors << validate_individual_telecom(nil, self.email, telecom_elements)
    errors.compact
  end

  private

  # Tries to find a single telecom value in a list of telecoms
  # Will return nil and do nothing if desired_value is nil.
  # Will return nil if it finds a matching telecom element
  # Will return a ContentError if it can't find a matching telecom value or
  # if there is a mismatch in the use attributes
  def validate_individual_telecom(possible_use_attribute, desired_value, telecom_elements)
    if desired_value
      stripped_desired_value = desired_value.gsub(/[-\(\)s]/, '')
      if possible_use_attribute
        stripped_desired_value = 'tel:' + stripped_desired_value
      else
        stripped_desired_value = 'mailto:' + stripped_desired_value
      end
      telecom_elements.each do |telecom_element|
        stripped_telecom_value = telecom_element.attributes['value'].gsub(/[-\(\)s]/, '')
        if stripped_desired_value.eql? stripped_telecom_value
          if telecom_element.attributes['use']
            if telecom_element.attributes['use'].eql? possible_use_attribute
              # Found the correct value and use
              return nil
            else
              # Mismatch in the use attribute
              return ContentError.new(:section => self.reachable_type.underscore, :subsection => 'telecom',
                                      :error_message => "Expected use #{possible_use_attribute} got #{telecom_element.attributes['use']}",
                                      :location=>telecom_element.xpath)
            end
          else
            # no use atttribute... assume we have a match... the C32 isn't real clear on
            # how to treat these
            return nil
          end
        end
      end
      
      # Fell through... couldn't find a match, so return an error
      return ContentError.new(:section => self.reachable_type.underscore, :subsection => 'telecom',
                              :error_message => "Couldn't find the telecom for #{desired_value}")
    else
      return nil
    end
  end

  def to_c32(xml= XML::Builder.new)
    if home_phone && home_phone.size > 0
      xml.telecom("use" => "HP", "value" => 'tel:' + home_phone)
    end
    if work_phone && work_phone.size > 0
     xml.telecom("use" => "WP", "value" => 'tel:' + work_phone)
    end
    if mobile_phone && mobile_phone.size > 0
      xml.telecom("use" => "MC", "value" => 'tel:' + mobile_phone)
    end
    if vacation_home_phone && vacation_home_phone.size > 0
      xml.telecom("use" => "HV", "value" => 'tel:' + vacation_home_phone)
    end
    if email && email.size > 0
      xml.telecom("value" => "mailto:" + email)
    end
    if url && url.size > 0
      xml.telecom("value" => url)
    end
  end

  def randomize()
    self.home_phone = format_number() 
    self.work_phone = format_number()
    self.mobile_phone = format_number()
  end

  def format_number()
    @number = Faker::PhoneNumber.phone_number
    @number = @number.gsub /\./, "-"
    @number = @number.gsub /\)/, "-"
    @number = @number.gsub /\(/, "1-"
    @number = @number.gsub /\ x.*/, ""
    if (@number.split("-")[0] == "1")
      @number = "+" + @number
    else
      @number = "+1-" + @number
    end
  end

end
