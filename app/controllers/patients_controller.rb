require_dependency 'sort_order'

class PatientsController < ApplicationController
  page_title 'Laika Test Library'
  before_filter :set_patient, :except => %w[ index create autoCreate ]

  include SortOrder
  self.valid_sort_fields = %w[ name created_at updated_at ]

  def index
    @patients = Patient.find(:all,
      :conditions => {:vendor_test_plan_id => nil},
      :order => sort_order || "name ASC")

    @vendors = current_user.vendors + Vendor.unclaimed

    @previous_vendor = last_selected_vendor
    @previous_kind   = last_selected_kind
  end
  
  def autoCreate
    @patient = Patient.new    
    @patient.registration_information = RegistrationInformation.new
    @patient.randomize()
    @patient.user = current_user
    @patient.save!
    redirect_to patient_url(@patient)
  end

  def create
    @patient = Patient.new(params[:patient])
    @patient.user = current_user
    @patient.save!
    redirect_to patient_url(@patient)
  rescue ActiveRecord::RecordInvalid => e
    flash[:notice] = e.to_s
    redirect_to patients_url
  end
  
  def checklist
    respond_to do |format|
      format.xml  
    end
  end

  def show
    if @patient.vendor_test_plan_id 
      @show_dashboard = true
    else
      @show_dashboard = false
    end
    respond_to do |format|
      format.html 
      format.xml  do
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.instruct!
        send_data @patient.to_c32(xml),
          :filename => "#{@patient.id}.xml",
          :type => 'application/x-download'
      end
    end
  end

  def set_no_known_allergies
    @patient.update_attribute(:no_known_allergies, true)
    render :partial => '/allergies/no_known_allergies'
  end
  
  def set_pregnant
    @patient.update_attribute(:pregnant, true)
  end
  
  def set_not_pregnant
    @patient.update_attribute(:pregnant, false)
  end
  
  def destroy
    @patient.destroy
    redirect_to patients_url
  end

  def edit_template_info
    render :layout => false
  end

  def update
    if @patient.update_attributes(params[:patient])
      render :partial => 'template_info'
    else
      render :action => 'edit_template_info', :layout => false
    end
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end

end
