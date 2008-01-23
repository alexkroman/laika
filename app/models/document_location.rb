class DocumentLocation < ActiveRecord::Base
  has_many :namespaces
  
  # Finds variables in the XPath Expression for this DocumentLocation
  # Returns an array containing the variable names. If there are no variables,
  # an empty array will be returned.
  def variable_names
    vars = []
    xpath_expression.scan(/\$(\w+)/) do |var_name|
      vars << var_name[0]
    end

    vars
  end
end
