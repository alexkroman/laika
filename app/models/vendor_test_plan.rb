class VendorTestPlan < ActiveRecord::Base
  has_one :patient_data
  belongs_to :vendor
  belongs_to :kind
  belongs_to :user
  has_one :clinical_document
  
  def validate_clinical_document_content
    results = {}
    document = REXML::Document.new(File.new(clinical_document.full_filename))
    results["registration_information"] = patient_data.registration_information.check_content(document, clinical_document.doc_type)
    results
  end
end
