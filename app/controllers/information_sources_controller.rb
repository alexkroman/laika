class InformationSourcesController < PatientDataChildController

  def new
    @information_source = InformationSource.new
    render :partial  => 'edit', :locals => {:information_source => @information_source,
                                            :patient_data => @patient_data}  
  end

  def edit
    @information_source = @patient_data.information_source
    render :partial  => 'edit', :locals => {:information_source => @information_source,
                                            :patient_data => @patient_data}
  end

  def create
    @information_source = InformationSource.new(params[:information_source])
    @patient_data.information_source = @information_source
    render :partial  => 'show', :locals => {:information_source => @information_source,
                                            :patient_data => @patient_data}
  end

  def update
    @information_source = @patient_data.information_source
    @information_source.update_attributes(params[:information_source])
    render :partial  => 'show', :locals => {:information_source => @information_source,
                                            :patient_data => @patient_data}
  end

  def destroy
    @information_source = @patient_data.information_source
    @information_source.destroy
    redirect_to patient_data_url
  end
end
