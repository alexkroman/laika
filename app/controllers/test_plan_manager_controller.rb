class TestPlanManagerController < ApplicationController

  def assign_patient_data
    
    copied_patient_data = PatientData.find(params[:pd_id]).copy

    # find the associated meta-data
    vendor = Vendor.find(params[:vendor_id])
    kind = Kind.find(params[:kind_id])
    user = User.find(params[:user_id])
    
    vtp = VendorTestPlan.new(:vendor => vendor, :kind => kind, :user => user)
    vtp.save!

    copied_patient_data.vendor_test_plan = vtp
    copied_patient_data.save!

    redirect_to vendor_test_plans_url
      
  end
end
