class ClinicalDocument < ActiveRecord::Base
  has_attachment :content_type => 'text/xml', 
                 :storage => :file_system, 
                 :max_size => 500.kilobytes
                 
  belongs_to :vendor_test_plan
end
