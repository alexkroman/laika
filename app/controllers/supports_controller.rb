class SupportsController < PatientDataChildController

  def new
    @support = Support.new
    @support.person_name = PersonName.new
    @support.address = Address.new
    @support.telecom = Telecom.new
    @isoCountries = IsoCountry.find(:all, :order => "name ASC")

    render :partial  => 'edit', :locals => {:support =>  @support,
                                            :patient_data => @patient_data}  
  end

  def edit
    @support = @patient_data.support
    @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    render :partial  => 'edit', :locals => {:support =>  @support,
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
