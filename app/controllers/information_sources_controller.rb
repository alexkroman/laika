class InformationSourcesController < PatientDataChildController

  def new
    @information_source = InformationSource.new
    @information_source.person_name = PersonName.new
    @information_source.address = Address.new
    @information_source.telecom = Telecom.new
    render :partial  => 'edit', :locals => {:information_source => @information_source,
                                            :patient_data => @patient_data}  
  end

  def edit
    @information_source = @patient_data.information_source
    
    unless @information_source.person_name
      @information_source.person_name = PersonName.new
    end
    unless @information_source.address
      @information_source.address = Address.new
    end
    unless @information_source.telecom
      @information_source.telecom = Telecom.new
    end
    
    render :partial  => 'edit', :locals => {:information_source => @information_source,
                                            :patient_data => @patient_data}
  end

  def create
    @information_source = InformationSource.new(params[:information_source])
    @patient_data.information_source = @information_source
    @information_source.create_person_attributes(params)
    render :partial  => 'show', :locals => {:information_source => @information_source,
                                            :patient_data => @patient_data}
  end

  def update
    @information_source = @patient_data.information_source
    @information_source.update_attributes(params[:information_source])
    @information_source.update_person_attributes(params)
    render :partial  => 'show', :locals => {:information_source => @information_source,
                                            :patient_data => @patient_data}
  end

  def destroy
    @information_source = @patient_data.information_source
    @information_source.destroy
    redirect_to patient_data_url
  end
end
