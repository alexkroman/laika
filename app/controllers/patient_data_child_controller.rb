class PatientDataChildController < ApplicationController

  before_filter :find_patient_data
  
  private

  def find_patient_data
    @patient_data_id = params[:patient_data_instance_id]
    redirect_to patient_data_url unless @patient_data_id
    @patient_data = PatientData.find(@patient_data_id)
  end


end
