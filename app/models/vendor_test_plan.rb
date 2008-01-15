class VendorTestPlan < ActiveRecord::Base
  has_one :patient_data
  belongs_to :vendor
  has_one :clinical_document
end
