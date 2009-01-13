class MedicationsController < PatientDataChildController

  def new
    @medication = Medication.new
    render :partial  => 'edit', :locals => {:medication => @medication,
                                            :patient_data => @patient_data}
  end

  def edit
    @medication = @patient_data.medications.find(params[:id])
    render :partial  => 'edit', :locals => {:medication => @medication,
                                            :patient_data => @patient_data}
  end

  def create
    @medication = Medication.new(params[:medication])
    @patient_data.medications << @medication
    render :partial  => 'create', :locals => {:medication => @medication,
                                              :patient_data => @patient_data}
  end

  def update
    @medication = @patient_data.medications.find(params[:id])
    @medication.update_attributes(params[:medication])
    render :partial  => 'show', :locals => {:medication => @medication,
                                            :patient_data => @patient_data}
  end

  # DELETE /medications/1
  # DELETE /medications/1.xml
  def destroy
    @medication = @patient_data.medications.find(params[:id])
    @medication.destroy
    render :partial  => 'delete.rjs'
  end
end
