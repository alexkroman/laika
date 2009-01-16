class CodeSystem < ActiveRecord::Base
  has_select_options :name => :select_options
  has_select_options :name => :medication_select_options,
    :order => "name DESC",
    :conditions => {
      :code => [ # performs a SQL IN
        '2.16.840.1.113883.6.88',  # RxNorm
        '2.16.840.1.113883.6.69',  # NDC
        '2.16.840.1.113883.4.9',   # FDA Unique Ingredient ID (UNIII)
        '2.16.840.1.113883.4.209'  # NDF RT
      ]
    }
  
end


