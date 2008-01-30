class RegistrationInformationController < PatientDataChildController

  def new
    @registration_information = RegistrationInformation.new
    @registration_information.person_name = PersonName.new
    @registration_information.address = Address.new

    render :partial  => 'edit', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def edit
    @registration_information = @patient_data.registration_information
    render :partial  => 'edit', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def create
    @registration_information = RegistrationInformation.new(params[:registration_information])
    @patient_data.registration_information = @registration_information
    @registration_information.person_name = PersonName.new(params[:person_name])
    @registration_information.address = Address.new(params[:address])
    render :partial  => 'show', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def update
    @registration_information = @patient_data.registration_information
    @registration_information.update_attributes(params[:registration_information])
    @registration_information.person_name.update_attributes(params[:person_name])
    @registration_information.address.update_attributes(params[:address])
    render :partial  => 'show', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def destroy
    @registration_information = @patient_data.registration_information
    @registration_information.destroy

    redirect_to patient_data_url
  end
  
end
