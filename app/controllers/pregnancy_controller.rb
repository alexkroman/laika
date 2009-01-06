class PregnancyController < ApplicationController

  def edit
    @patient_data = PatientData.find params[:patient_data_instance_id]
    render :layout => false
  end

  def update
    @patient_data_id = params[:patient_data_instance_id]
    @patient_data = PatientData.find(@patient_data_id)
    pregnancy = false;
    if params[:pregnant] == 'on'
      pregnancy = true
    end
    @patient_data.pregnant = pregnancy
    @patient_data.save!
    render :partial  => 'show'
  end
  
  # DELETE /pregnancy/1
  # DELETE /pregnancy/1.xml
  def destroy
    @patient_data_id = params[:patient_data_instance_id]
    @patient_data = PatientData.find(@patient_data_id)
    @patient_data.pregnant = nil
    @patient_data.save!
    render :partial  => 'show'
  end

end
