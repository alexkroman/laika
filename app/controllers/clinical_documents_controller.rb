class ClinicalDocumentsController < ApplicationController
  before_filter :find_vendor_test_plan

  def edit
    @clinical_document = @vendor_test_plan.clinical_document
  end

  def create
    @clinical_document = ClinicalDocument.new(params[:clinical_document])
    @vendor_test_plan.clinical_document = @clinical_document
    begin
    logger.debug("calling validate")
    @vendor_test_plan.validate_clinical_document_content
    rescue
      logger.error($!)
        flash[:notice] = "An error occurred while validating the document"
    end
    
    redirect_to vendor_test_plans_url
  end

  def update
    @clinical_document = @vendor_test_plan.clinical_document
    @clinical_document.update_attributes(params[:clinical_document])
    begin
    @vendor_test_plan.validate_clinical_document_content
    rescue
        flash[:notice] = "An error occurred while validating the document"
    end
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
  
end
