class MedicationsController < PatientDataChildController

  def new
    @medication = Medication.new
    @medicationTypes = MedicationType.find(:all, :order => "name ASC")
    @codeSystems = CodeSystem.find(:all, :order => "name DESC")

    render :partial  => 'edit', :locals => {:medication => @medication,
                                            :patient_data => @patient_data}
  end

  def edit
    @medication = @patient_data.medications.find(params[:id])
    @medicationTypes = MedicationType.find(:all, :order => "name ASC")
    @codeSystems = CodeSystem.find(:all, :order => "name DESC")
    
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

    redirect_to patient_data_url
  end
end
