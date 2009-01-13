class CodeSystem < ActiveRecord::Base
  named_scope :all, :order => 'name ASC'
  named_scope :medication, :conditions => {
    :code => [ # performs a SQL IN
      '2.16.840.1.113883.6.88',  # RxNorm
      '2.16.840.1.113883.6.69',  # NDC
      '2.16.840.1.113883.4.9',   # FDA Unique Ingredient ID (UNIII)
      '2.16.840.1.113883.4.209'  # NDF RT
    ]
  }, :order => "name DESC"
  
end


