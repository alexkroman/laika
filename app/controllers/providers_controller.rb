class ProvidersController < PatientDataChildController
  def new
    @provider = Provider.new
    @provider.person_name = PersonName.new
    @provider.address = Address.new
    @provider.telecom = Telecom.new

    render :partial  => 'edit', :locals => {:provider =>  @provider,
                                            :patient_data => @patient_data}  
  end

  def edit
    @provider = @patient_data.support
    render :partial  => 'edit', :locals => {:provider =>  @provider,
                                            :patient_data => @patient_data}
  end

  def create
    @support = Support.new(params[:support])
    @patient_data.support = @support
    @support.create_person_attributes(params)
    render :partial  => 'show', :locals => {:support =>  @support,
                                            :patient_data => @patient_data}
  end

  def update
    @support = @patient_data.support

    @support.update_attributes(params[:support])
    @support.update_person_attributes(params)
    render :partial  => 'show', :locals => {:support =>  @support,
                                            :patient_data => @patient_data}
  end

  def destroy
    @support = @patient_data.support
    @support.destroy

    redirect_to patient_data_url
  end
end
