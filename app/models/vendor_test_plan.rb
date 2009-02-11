class VendorTestPlan < ActiveRecord::Base

  has_one :patient_data, :dependent => :destroy
  belongs_to :vendor
  belongs_to :kind
  belongs_to :user

  has_one :clinical_document, :dependent => :destroy
  has_many :content_errors, :dependent => :destroy

  #before_save :_bf
  #after_save :_bf
  def _bf
    puts self.errors
  end
  
  def validate_clinical_document_content
    content_errors.clear
    document = clinical_document.as_xml_document
    logger.debug(Validation.get_validator(clinical_document.doc_type).inspect)
    errors =  Validation.get_validator(clinical_document.doc_type).validate(patient_data, document)
    logger.debug(errors.inspect)
    logger.debug("PD #{patient_data}  doc #{document}")
    content_errors.concat  Validation.get_validator(clinical_document.doc_type).validate(patient_data, document)
    content_errors
  end


  def count_errors_and_warnings
    errors = content_errors.count(:conditions=>["msg_type = 'error' "])
    warnings = content_errors.count(:conditions=>["msg_type = 'warning' "])
   
    return errors, warnings
  end

 

end
