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
  
  # Examines provided patient data for values to bind to the variables in
  # the DocumentLocation's XPath Expression. If all variables can be bound
  # a hash will be returned containing the variable names as keys. If a
  # variable cannot be bound, nil will be returned.
  def bind_variables(patient_data)
    bound_vars = {}
    section_object = patient_data.send(section.to_sym)
    variable_names.each do |variable_name|
      variable_value = section_object.send(variable_name.to_sym)
      if variable_value
        bound_vars[variable_name] = variable_value
      else
        return nil
      end
    end
    
    bound_vars
  end
end
