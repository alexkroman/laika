class InsuranceProvidersController < PatientDataChildController

  def new
    
    @insurance_provider = InsuranceProvider.new
    
    @insurance_provider.insurance_provider_patient = InsuranceProviderPatient.new
    @insurance_provider.insurance_provider_patient.person_name = PersonName.new
    @insurance_provider.insurance_provider_patient.address = Address.new
    @insurance_provider.insurance_provider_patient.telecom = Telecom.new
    
    @insurance_provider.insurance_provider_subscriber = InsuranceProviderSubscriber.new
    @insurance_provider.insurance_provider_subscriber.person_name = PersonName.new
    @insurance_provider.insurance_provider_subscriber.address = Address.new
    @insurance_provider.insurance_provider_subscriber.telecom = Telecom.new
    
    @insurance_provider.insurance_provider_guarantor = InsuranceProviderGuarantor.new
    @insurance_provider.insurance_provider_guarantor.person_name = PersonName.new
    @insurance_provider.insurance_provider_guarantor.address = Address.new
    @insurance_provider.insurance_provider_guarantor.telecom = Telecom.new
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@insuranceTypes
      @insuranceTypes = InsuranceType.find(:all, :order => "name ASC")
    end
    if !@roleClassRelationshipFormalTypes
      @roleClassRelationshipFormalTypes = RoleClassRelationshipFormalType.find(:all, :order => "name ASC")
    end
    if !@coverageRoleTypes
      @coverageRoleTypes = CoverageRoleType.find(:all, :order => "name ASC")
    end
    
    render :partial  => 'edit', :locals => {:insurance_provider =>  @insurance_provider,
                                            :patient_data => @patient_data}  
  end

  def edit
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@insuranceTypes
      @insuranceTypes = InsuranceType.find(:all, :order => "name ASC")
    end
    if !@roleClassRelationshipFormalTypes
      @roleClassRelationshipFormalTypes = RoleClassRelationshipFormalType.find(:all, :order => "name ASC")
    end
    if !@coverageRoleTypes
      @coverageRoleTypes = CoverageRoleType.find(:all, :order => "name ASC")
    end
    
    @insurance_provider = @patient_data.insurance_providers.find(params[:id])

    render :partial  => 'edit', :locals => {:insurance_provider =>  @insurance_provider,
                                            :patient_data => @patient_data}
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
   
    render :partial  => 'show', :locals => {:insurance_provider =>  @insurance_provider,
                                            :patient_data => @patient_data}
  end

  def update
    
    @insurance_provider = @patient_data.insurance_providers.find(params[:id])
    @insurance_provider.update_attributes(params[:insurance_provider])
    
    @insurance_provider.insurance_provider_patient.update_attributes(params[:insurance_provider_patient])
    @insurance_provider.insurance_provider_subscriber.update_attributes(params[:insurance_provider_subscriber])
    @insurance_provider.insurance_provider_guarantor.update_attributes(params[:insurance_provider_guarantor])

    render :partial  => 'show', :locals => {:insurance_provider =>  @insurance_provider,
                                            :patient_data => @patient_data}
  end

  def destroy
    @insurance_provider = @patient_data.insurance_providers.find(params[:id])
    @insurance_provider.destroy
    
    render :partial  => 'delete.rjs'
  end

end
