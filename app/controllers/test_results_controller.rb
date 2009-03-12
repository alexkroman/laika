class TestResultsController < ApplicationController
  before_filter :find_vendor_test_plan

  def create
    @test_result = TestResult.new(params[:test_result])

    for patient_identifier in @vendor_test_plan.patient_data.patient_identifiers
      if patient_identifier.patient_identifier == @test_result.patient_identifier && patient_identifier.identifier_domain_identifier == @test_result.assigning_authority
        @test_result.result = 'PASS'
      end
    end
    
    @vendor_test_plan.test_result = @test_result

    redirect_to vendor_test_plans_url
  end

  private

  def find_vendor_test_plan
    @vendor_test_plan_id = params[:vendor_test_plan_id]
    redirect_to vendor_test_plans_url unless @vendor_test_plan_id
    @vendor_test_plan = VendorTestPlan.find(@vendor_test_plan_id)
  end

end
