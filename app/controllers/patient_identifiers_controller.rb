class PatientIdentifiersController < PatientDataChildController

  def new
    @patient_identifier = PatientIdentifier.new
    render :partial  => 'edit', :locals => {:patient_identifier => @patient_identifier,
                                            :patient_data => @patient_data}
  end

  def edit
    @patient_identifier = @patient_data.patient_identifiers.find(params[:id])
    render :partial  => 'edit', :locals => {:patient_identifier => @patient_identifier,
                                            :patient_data => @patient_data}
  end

  def create
    @patient_identifier = PatientIdentifier.new(params[:patient_identifier])
    @patient_data.patient_identifiers << @patient_identifier
    render :partial  => 'create', :locals => {:patient_identifier => @patient_identifier,
                                              :patient_data => @patient_data}
  end

  def update
    @patient_identifier = @patient_data.patient_identifiers.find(params[:id])
    @patient_identifier.update_attributes(params[:patient_identifier])
    render :partial  => 'show', :locals => {:patient_identifier => @patient_identifier,
                                            :patient_data => @patient_data}
  end

  # DELETE /patient_identifiers/1
  # DELETE /patient_identifiers/1.xml
  def destroy
    @patient_identifier =  @patient_data.patient_identifiers.find(params[:id])
    @patient_identifier.destroy
    render :partial  => 'delete.rjs'
  end
end
