class RegistrationInformationController < PatientChildController

  def edit
    @registration_information = @patient.registration_information
  end

  def create
    registration_information = RegistrationInformation.new(params[:registration_information])
    @patient.registration_information = registration_information
    registration_information.create_person_attributes(params)

    render :partial  => 'show', :locals => {:registration_information => registration_information,
                                            :patient => @patient}
  end

  def update
    registration_information = @patient.registration_information
    registration_information.update_attributes(params[:registration_information])
    registration_information.update_person_attributes(params)
    render :partial  => 'show', :locals => {:registration_information => registration_information,
                                            :patient => @patient}
  end

  def destroy
    registration_information = @patient.registration_information
    registration_information.destroy
    
    render :partial  => 'show', :locals => {:registration_information =>  nil,
                                               :patient => @patient}
  end
  
end
