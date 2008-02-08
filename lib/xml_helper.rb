module XmlHelper
  # This method first checks expected_value. If it is nil, it does nothing
  # and returns nil.
  #
  # Otherwise, it will use the expression to a node to evaluate. It will use the
  # first node it finds. It will then try to match the expected_value to the returned
  # node. If the node is an Element, it will call text. If it is an attribute
  # it will call value.
  # Nil will be returned if the values match.
  # If the values do not match, or if the node cannot be found, and error
  # string will be returned.
  def self.match_value(element, expression, expected_value)
    error = nil
    if expected_value
      desired_node = REXML::XPath.first(element, expression, {'cda' => 'urn:hl7-org:v3'})
      if desired_node
        actual_value = nil
        if desired_node.respond_to?(:text)
          actual_value = desired_node.text
        else
          actual_value = desired_node.value
        end
        
        unless expected_value.eql?(actual_value)
          error = "Expected #{expected_value} got #{actual_value}"
        end
        
      else
        error = "Couldn't find xml"
      end
    end
    
    error
  end
end