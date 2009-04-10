class InsuranceProvidersController < PatientDataChildController

  def new

    @insurance_provider = InsuranceProvider.new

    @insurance_provider.insurance_provider_patient = InsuranceProviderPatient.new
    @insurance_provider.insurance_provider_patient.person_name = PersonName.new
    @insurance_provider.insurance_provider_patient.address = Address.new
    @insurance_provider.insurance_provider_patient.telecom = Telecom.new
    @insurance_provider_patient = @insurance_provider.insurance_provider_patient

    @insurance_provider.insurance_provider_subscriber = InsuranceProviderSubscriber.new
    @insurance_provider.insurance_provider_subscriber.person_name = PersonName.new
    @insurance_provider.insurance_provider_subscriber.address = Address.new
    @insurance_provider.insurance_provider_subscriber.telecom = Telecom.new
    @insurance_provider_subscriber = @insurance_provider.insurance_provider_subscriber

    @insurance_provider.insurance_provider_guarantor = InsuranceProviderGuarantor.new
    @insurance_provider.insurance_provider_guarantor.person_name = PersonName.new
    @insurance_provider.insurance_provider_guarantor.address = Address.new
    @insurance_provider.insurance_provider_guarantor.telecom = Telecom.new
    @insurance_provider_guarantor = @insurance_provider.insurance_provider_guarantor

    render :action => 'edit'
  end

  def create
    @insurance_provider = InsuranceProvider.new(params[:insurance_provider])

    @insurance_provider.insurance_provider_patient = InsuranceProviderPatient.new(params[:insurance_provider_patient])
    @insurance_provider.insurance_provider_patient.person_name = PersonName.new
    @insurance_provider.insurance_provider_patient.address = Address.new
    @insurance_provider.insurance_provider_patient.telecom = Telecom.new

    @insurance_provider.insurance_provider_subscriber = InsuranceProviderSubscriber.new(params[:insurance_provider_subscriber])
    @insurance_provider.insurance_provider_subscriber.person_name = PersonName.new
    @insurance_provider.insurance_provider_subscriber.address = Address.new
    @insurance_provider.insurance_provider_subscriber.telecom = Telecom.new

    @insurance_provider.insurance_provider_guarantor = InsuranceProviderGuarantor.new(params[:insurance_provider_guarantor])
    @insurance_provider.insurance_provider_guarantor.person_name = PersonName.new
    @insurance_provider.insurance_provider_guarantor.address = Address.new
    @insurance_provider.insurance_provider_guarantor.telecom = Telecom.new

    @patient_data.insurance_providers << @insurance_provider
  end
end
