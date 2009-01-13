class InsuranceProviderPatientsController < PatientDataChildController

  def edit
    for insurance_provider in @patient_data.insurance_providers 
      if (insurance_provider.insurance_provider_patient.id.to_s == params[:id])
        @insurance_provider_patient = insurance_provider.insurance_provider_patient
      end
    end

    render :partial  => 'edit', :locals => {:insurance_provider_patient =>  @insurance_provider_patient,
                                            :patient_data => @patient_data}
  end

  def update
    for insurance_provider in @patient_data.insurance_providers 
      if (insurance_provider.insurance_provider_patient.id.to_s == params[:id])
        @insurance_provider_patient = insurance_provider.insurance_provider_patient
      end
    end

    @insurance_provider_patient.update_attributes(params[:insurance_provider_patient])
    @insurance_provider_patient.update_person_attributes(params)

    render :partial  => 'show', :locals => {:insurance_provider_patient =>  @insurance_provider_patient,
                                            :patient_data => @patient_data}
  end

end
