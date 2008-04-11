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
  
  def validated?
      clinical_document.andand.validated?
  end
  
  
  def cache_validation_report
        validate_clinical_document_content
         xmlc = ""
         File.open(clinical_document.full_filename) do |f|
             xmlc =  f.read()
         end 
         doc = REXML::Document.new xmlc
         report = ValidationUtil.validate('C32',xmlc)
         #add_inspection_results_to_validation_errors(report)
         clinical_document.validation_report=report.to_s
  end  
    
 
   def add_inspection_results_to_validation_errors(val_errors)
       el = val_errors.root.add_element "Result",{"isValid"=>content_errors.length == 0,
                'validator'=>'Content Inspection'}
            
            content_errors.each do |err|
               err_el = el.add_element "error" 
               err_el.text = %{ Section: #{err.section} 
                                Subsection: #{err.subsection}
                                Field Name: #{err.field_name}
                                Error Message: #{err. error_message}
               }
               if err.location
                   err_el.add_attribute "location", err.location
               end
            end
    end      
end
