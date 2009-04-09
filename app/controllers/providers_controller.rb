class ProvidersController < PatientDataChildController
  
  def new
    @provider = Provider.new
    render :partial  => 'edit', :locals => {:provider =>  @provider,
                                            :patient_data => @patient_data}  
  end

  def edit
    @provider = @patient_data.providers.find(params[:id])
    
    render :partial  => 'edit', :locals => {:provider =>  @provider,
                                            :patient_data => @patient_data}
  end

  def create
    @provider = Provider.new(params[:provider])
    @patient_data.providers << @provider
    @provider.create_person_attributes(params)
    render :partial  => 'show', :locals => {:provider =>  @provider,
                                            :patient_data => @patient_data}
  end

  def update
    @provider = @patient_data.providers.find(params[:id])

    @provider.update_attributes(params[:provider])
    @provider.update_person_attributes(params)
    render :partial  => 'show', :locals => {:provider =>  @provider,
                                            :patient_data => @patient_data}
  end

  def destroy
    @provider = @patient_data.providers.find(params[:id])
    @provider.destroy
    render :partial  => 'delete.rjs'
  end
end
