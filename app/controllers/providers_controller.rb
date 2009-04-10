class ProvidersController < PatientDataChildController
  def create
    @provider = Provider.new(params[:provider])
    @patient_data.providers << @provider
    @provider.create_person_attributes(params)
  end

  def update
    @provider = @patient_data.providers.find(params[:id])

    @provider.update_attributes(params[:provider])
    @provider.update_person_attributes(params)
    render :partial  => 'show', :locals => {:provider =>  @provider,
                                            :patient_data => @patient_data}
  end
end
