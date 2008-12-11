class PatientDataChildController < ApplicationController

  before_filter :find_patient_data
  
  private

  def find_patient_data
    if params[:patient_data_instance_id]
      @patient_data = PatientData.find params[:patient_data_instance_id]
    end
    redirect_to patient_data_url unless @patient_data
  end

end
