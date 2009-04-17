class InsuranceProviderGuarantorsController < PatientChildController

  def update
    insurance_provider_guarantor = @patient.insurance_provider_guarantors.find(params[:id])
    insurance_provider_guarantor.update_attributes(params[:insurance_provider_guarantor])
    insurance_provider_guarantor.update_person_attributes(params)

    render :partial  => 'show', :locals => {
      :insurance_provider_guarantor => insurance_provider_guarantor,
      :patient                 => @patient
    }
  end

end
