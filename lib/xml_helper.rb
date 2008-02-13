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
  def self.match_value(element, expression, expected_value, namespaces={'cda' => 'urn:hl7-org:v3'},bind_variables = {})
    error = nil
    
      desired_node = REXML::XPath.first(element, expression, namespaces,bind_variables)
     
        actual_value = nil
        
        if desired_node.kind_of?(String) ||
           desired_node.kind_of?(TrueClass)||
           desired_node.kind_of?(FalseClass) ||
           desired_node.kind_of?(NilClass)
           actual_value = desired_node           
        elsif desired_node.respond_to?(:text)
          actual_value = desired_node.text
        else
          actual_value = desired_node.value
        end
        
        unless expected_value.eql?(actual_value)
          error = "Expected #{(expected_value)? expected_value.to_s : 'nil'} got #{(actual_value) ? actual_value : 'nil'}"
        end    
    error
  end
end