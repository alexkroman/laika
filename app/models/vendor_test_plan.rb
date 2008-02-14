class VendorTestPlan < ActiveRecord::Base
  has_one :patient_data
  belongs_to :vendor
  belongs_to :kind
  belongs_to :user
  has_one :clinical_document
  
  def validate_clinical_document_content
    document = REXML::Document.new(File.new(clinical_document.full_filename))
    patient_data.validate_c32(document)
  end
end
