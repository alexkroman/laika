class InsuranceProviderSubscribersController < PatientDataChildController

  def edit
    @insurance_provider_subscriber = @patient_data.insurance_provider_subscribers.find(params[:id])
  end

  def update
    insurance_provider_subscriber = @patient_data.insurance_provider_subscribers.find(params[:id])
    insurance_provider_subscriber.update_attributes(params[:insurance_provider_subscriber])
    insurance_provider_subscriber.update_person_attributes(params)

    render :partial  => 'show', :locals => {
      :insurance_provider_subscriber => insurance_provider_subscriber,
      :patient_data                  => @patient_data
    }
  end

end
