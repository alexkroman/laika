class VendorTestPlan < ActiveRecord::Base
  has_one :patient_data
  belongs_to :vendor
  belongs_to :kind
  belongs_to :user
  has_one :clinical_document
  has_many :content_errors
  
  def validate_clinical_document_content
    content_errors.clear
    document = REXML::Document.new(File.new(clinical_document.full_filename))
    content_errors.concat  patient_data.validate_c32(document)
    content_errors
  end
end
