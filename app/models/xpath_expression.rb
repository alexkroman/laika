class XpathExpression < ActiveRecord::Base
  
  # Looks up an XPath expression by the name and doc_type. It then applies
  # the XPath expression to the element passed returning the first
  # matching node
  def self.execute_expression_against_element(element, expression_name, doc_type)
    desired_expression = find_by_name_and_doc_type(expression_name, doc_type)
    REXML::XPath.first(element, desired_expression.expression, {'cda' => 'urn:hl7-org:v3'})
  end
  
  # This method first checks expected_value. If it is nil, it does nothing
  # and returns nil.
  #
  # Otherwist, it will use execute_expression_against_element to find a node
  # to evaluate. It will then try to match the expected_value to the returned
  # node. If the node is an Element, it will call text. If it is an attribute
  # it will call value.
  # Nil will be returned if the values match.
  # If the values do not match, or if the node cannot be found, and error
  # string will be returned.
  def self.match_value(element, expression_name, doc_type, expected_value)
    error = nil
    if expected_value
      desired_node = execute_expression_against_element(element, expression_name, doc_type)
      if desired_node
        actual_value = nil
        if desired_node.respond_to?(:text)
          actual_value = desired_node.text
        else
          actual_value = desired_node.value
        end
        
        unless expected_value.eql?(actual_value)
          error = "For #{expression_name.humanize} expected #{expected_value} got #{actual_value}"
        end
        
      else
        error = "Couldn't find xml for #{expression_name.humanize}"
      end
    end
    
    error
  end
end
