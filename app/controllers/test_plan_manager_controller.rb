class TestPlanManagerController < ApplicationController

  def assign_patient_data
    copied_patient_data = PatientData.find(params[:pd_id]).copy
    vendor = Vendor.find(params[:vendor_id])
    vtp = VendorTestPlan.new(:vendor => vendor)
    vtp.save!
    copied_patient_data.vendor_test_plan = vtp
    copied_patient_data.save!

    redirect_to vendor_test_plans_url
  end
end
