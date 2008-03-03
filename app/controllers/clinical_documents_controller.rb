class ClinicalDocumentsController < ApplicationController
  before_filter :find_vendor_test_plan

  def edit
    @clinical_document = @vendor_test_plan.clinical_document
  end

  def create
    @clinical_document = ClinicalDocument.new(params[:clinical_document])
    @vendor_test_plan.clinical_document = @clinical_document
    cache_validation_report
    redirect_to vendor_test_plans_url
  end

  def update
    @clinical_document = @vendor_test_plan.clinical_document
    @clinical_document.update_attributes(params[:clinical_document])
    cache_validation_report
    redirect_to vendor_test_plans_url
  end

  def destroy
    @clinical_document = @vendor_test_plan.clinical_document
    @clinical_document.destroy
    redirect_to vendor_test_plans_url
  end
  
  private
  
  def find_vendor_test_plan
    @vendor_test_plan_id = params[:vendor_test_plan_id]
    redirect_to vendor_test_plans_url unless @vendor_test_plan_id
    @vendor_test_plan = VendorTestPlan.find(@vendor_test_plan_id)
  end
  
  def cache_validation_report
      
       xmlc = ""
       File.open(@clinical_document.full_filename) do |f|
           xmlc =  f.read()
       end 
 
       doc = REXML::Document.new xmlc
       report = ValidationUtil.validate('C32',xmlc)
       add_inspection_results_to_validation_errors(report,@vendor_test_plan.validate_clinical_document_content)
       @clinical_document.validation_report=report.to_s
 end  
  
 def add_inspection_results_to_validation_errors(val_errors, inspection_results)
          el = val_errors.root.add_element "Result",{"isValid"=>inspection_results.length == 0,
              'validator'=>'Content Inspection'}
          
          inspection_results.each do |err|
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
