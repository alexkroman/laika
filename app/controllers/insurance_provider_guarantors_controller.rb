class InsuranceProviderGuarantorsController < PatientDataChildController

  def edit
    for insurance_provider in @patient_data.insurance_providers 
      if (insurance_provider.insurance_provider_guarantor.id.to_s == params[:id])
        @insurance_provider_guarantor = insurance_provider.insurance_provider_guarantor
      end
    end

    render :partial  => 'edit', :locals => {:insurance_provider_guarantor =>  @insurance_provider_guarantor,
                                            :patient_data => @patient_data}
  end

  def update
    for insurance_provider in @patient_data.insurance_providers 
      if (insurance_provider.insurance_provider_guarantor.id.to_s == params[:id])
        @insurance_provider_guarantor = insurance_provider.insurance_provider_guarantor
      end
    end

    @insurance_provider_guarantor.update_attributes(params[:insurance_provider_guarantor])
    @insurance_provider_guarantor.update_person_attributes(params)

    render :partial  => 'show', :locals => {:insurance_provider_guarantor =>  @insurance_provider_guarantor,
                                            :patient_data => @patient_data}
  end

end
