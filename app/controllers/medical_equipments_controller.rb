class MedicalEquipmentsController < PatientDataChildController

  def new
  	@medical_equipment = MedicalEquipment.new
    render :partial  => 'edit', :locals => {:medical_equipment => @medical_equipment,
                                            :patient_data => @patient_data}
  end

  def edit
  	@medical_equipment = @patient_data.medical_equipments.find(params[:id])
    render :partial  => 'edit', :locals => {:medical_equipment => @medical_equipment,
                                            :patient_data => @patient_data}
  end

  def create
    @medical_equipment = MedicalEquipment.new(params[:medical_equipment])
    @patient_data.medical_equipments << @medical_equipment
    render :partial  => 'create', :locals => {:medical_equipment => @medical_equipment,
                                              :patient_data => @patient_data}
  end

  def update
    @medical_equipment = @patient_data.medical_equipments.find(params[:id])
    @medical_equipment.update_attributes(params[:medical_equipment])
    render :partial  => 'show', :locals => {:medical_equipment => @medical_equipment,
                                            :patient_data => @patient_data}
  end

  # DELETE /medical_equipments/1
  # DELETE /medical_equipments/1.xml
  def destroy
    @medical_equipment = @patient_data.medical_equipments.find(params[:id])
    @medical_equipment.destroy
    render :partial  => 'delete.rjs'
  end
end
