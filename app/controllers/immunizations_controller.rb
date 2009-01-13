class ImmunizationsController < PatientDataChildController

  def new
    @immunization = Immunization.new
    render :partial  => 'edit', :locals => {:immunization => @immunization,
                                            :patient_data => @patient_data}
  end

  def edit
    @immunization = @patient_data.immunizations.find(params[:id])
    render :partial  => 'edit', :locals => {:immunization => @immunization,
                                            :patient_data => @patient_data}
  end

  def create
    @immunization = Immunization.new(params[:immunization])
    @patient_data.immunizations << @immunization
    render :partial  => 'create', :locals => {:immunization => @immunization,
                                              :patient_data => @patient_data}
  end

  def update
    @immunization = @patient_data.immunizations.find(params[:id])
    @immunization.update_attributes(params[:immunization])
    render :partial  => 'show', :locals => {:immunization => @immunization,
                                            :patient_data => @patient_data}
  end

  # DELETE /immunizations/1
  # DELETE /immunizations/1.xml
  def destroy
    @immunization = @patient_data.immunizations.find(params[:id])
    @immunization.destroy
    render :partial  => 'delete.rjs'
  end
end
