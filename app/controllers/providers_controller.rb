class ProvidersController < PatientDataChildController
  
  def new
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@providerRoles
      @providerRoles = ProviderRole.find(:all, :order => "name ASC")
    end
    if !@providerTypes 
      @providerTypes = ProviderType.find(:all, :order => "name ASC") 
    end
    
    @provider = Provider.new
    @provider.person_name = PersonName.new
    @provider.address = Address.new
    @provider.telecom = Telecom.new
    
    render :partial  => 'edit', :locals => {:provider =>  @provider,
                                            :patient_data => @patient_data}  
  end

  def edit
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@providerRoles
      @providerRoles = ProviderRole.find(:all, :order => "name ASC")
    end
    if !@providerTypes 
      @providerTypes = ProviderType.find(:all, :order => "name ASC") 
    end
    
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
