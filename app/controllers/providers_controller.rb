class ProvidersController < PatientDataChildController
  def create
    @provider = Provider.new(params[:provider])
    @patient.providers << @provider
    @provider.create_person_attributes(params)
  end

  def update
    @provider = @patient.providers.find(params[:id])

    @provider.update_attributes(params[:provider])
    @provider.update_person_attributes(params)
    render :partial  => 'show', :locals => {:provider =>  @provider,
                                            :patient_data => @patient}
  end
end
