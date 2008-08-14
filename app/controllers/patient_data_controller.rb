require 'faker'

class PatientDataController < ApplicationController

  def index
    @patient_data_list = PatientData.find(:all, :conditions => {:vendor_test_plan_id => nil}, :order => "name ASC")
    @vendors = Vendor.find(:all)
    @kinds = Kind.find(:all)
    @users = User.find(:all)
  end
  
  def autoCreate
    @patient_data = PatientData.new    
    @patient_data.registration_information = RegistrationInformation.new
    @patient_data.randomize()
    @patient_data.user = current_user
    @patient_data.save!
    redirect_to :controller => 'patient_data', :action => 'show', :id => @patient_data.id
  end

  def create
    @patient_data = PatientData.new(params[:patient_data])
    @patient_data.user = current_user
    if @patient_data.name == ""
      #$no_patient_name = true
      redirect_to ActionController::AbstractRequest.relative_url_root + '/patient_data'
    else
      #$no_patient_name = false
      @patient_data.save!
      redirect_to :controller => 'patient_data', :action => 'show', :id => @patient_data.id
    end
  end
  
  def checklist
    @patient_data = PatientData.find(params[:id])
    respond_to do |format|
      format.xml  
    end
  end

  def show
    @patient_data = PatientData.find(params[:id])
    if @patient_data.vendor_test_plan_id 
      @show_dashboard = true
    else
      @show_dashboard = false
    end
    respond_to do |format|
      format.html 
      format.xml  
    end
  end

  def set_no_known_allergies
    @patient_data = PatientData.find(params[:id])
    @patient_data.update_attribute(:no_known_allergies, true)
    render :partial => '/allergies/no_known_allergies'
  end
  
  def set_pregnant
    @patient_data = PatientData.find(params[:id])
    @patient_data.update_attribute(:pregnant, true)
  end
  
  def set_not_pregnant
    @patient_data = PatientData.find(params[:id])
    @patient_data.update_attribute(:pregnant, false)
  end
  
  def destroy
    @patient_data = PatientData.find(params[:id])
    @patient_data.destroy
    redirect_to :controller => 'patient_data', :action => 'index'
  end

end
