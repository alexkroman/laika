class InsuranceProvidersController < PatientDataChildController

  def new
    
    @insurance_provider = InsuranceProvider.new
    
    @insurance_provider.insurance_provider_patient = InsuranceProviderPatient.new
    @insurance_provider.insurance_provider_subscriber = InsuranceProviderSubsriber.new
    @insurance_provider.insurance_provider_guarantor = InsuranceProviderGuarantor.new
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@insuranceTypes
      @insuranceTypes = InsuranceType.find(:all, :order => "code ASC")
    end
    if !@roleClassRelationshipFormalTypes
      @roleClassRelationshipFormalTypes = RoleClassRelationshipFormalType.find(:all, :order => "code ASC")
    end
    
    render :partial  => 'edit', :locals => {:insurance_provider =>  @insurance_provider,
                                            :patient_data => @patient_data}  
  end

  def edit
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@insuranceTypes
      @insuranceTypes = InsuranceType.find(:all, :order => "code ASC")
    end
    if !@roleClassRelationshipFormalTypes
      @roleClassRelationshipFormalTypes = RoleClassRelationshipFormalType.find(:all, :order => "code ASC")
    end
    
    @insurance_provider = @patient_data.insurance_providers.find(params[:id])

    render :partial  => 'edit', :locals => {:insurance_provider =>  @insurance_provider,
                                            :patient_data => @patient_data}
  end

  def create
    
    @insurance_provider = InsuranceProvider.new(params[:insurance_provider])
    
    @insurance_provider.create_insurance_provider_patient_attributes(params)
    @insurance_provider.create_insurance_provider_subscriber_attributes(params)
    @insurance_provider.create_insurance_provider_guarantorattributes(params)
    
    @patient_data.insurance_providers << @insurance_provider
   
    render :partial  => 'show', :locals => {:insurance_provider =>  @insurance_provider,
                                            :patient_data => @patient_data}
  end

  def update
    
    @insurance_provider = @patient_data.insurance_providers.find(params[:id])
    @insurance_provider.update_attributes(params[:insurance_provider])
    
    #@insurance_provider.update_insurance_provider_patient_attributes(params)
    #@insurance_provider.update_insurance_provider_subscriber_attributes(params)
    #@insurance_provider.update_insurance_provider_guarantorattributes(params)

    render :partial  => 'show', :locals => {:insurance_provider =>  @insurance_provider,
                                            :patient_data => @patient_data}
  end

  def destroy
    
    @insurance_provider = @patient_data.insurance_provider
    @insurance_provider.destroy
    
    redirect_to patient_data_url
    
  end
end
