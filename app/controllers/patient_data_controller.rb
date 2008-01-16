class PatientDataController < ApplicationController

  def index
    @patient_data_list = PatientData.find(:all, :conditions => {:vendor_test_plan_id => nil})
    @vendors = Vendor.find(:all)
  end

  def create
    patient_data = PatientData.new
    patient_data.name = params[:name]
    patient_data.save!
    redirect_to :action => 'show', :id => patient_data.id
  end
  
  def create_vendor_test_plan
    copied_patient_data = PatientData.find(params[:pd_id]).copy
    vendor = Vendor.find(params[:vendor_id])
    vtp = VendorTestPlan.new(:vendor => vendor)
    vtp.save!
    copied_patient_data.vendor_test_plan = vtp
    copied_patient_data.save!
    
    redirect_to :controller => 'vendor_test_plans', :action => 'list'
  end
  
  def show
    @patient_data = PatientData.find(params[:id])
  end

  def patient_story
    @patient_data = PatientData.find(params[:id])
  end
  
  def patient_xml
    @patient_data = PatientData.find(params[:id])
  end
end
