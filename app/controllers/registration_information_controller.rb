class RegistrationInformationController < PatientDataChildController

  def new
    @registration_information = RegistrationInformation.new
    @registration_information.person_name = PersonName.new
    @registration_information.address = Address.new
    @registration_information.telecom = Telecom.new
    @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    @races = Race.find(:all, :order => "name ASC")
    @ethnicities = Ethnicity.find(:all, :order => "name ASC")
    @religions = Religion.find(:all, :order => "name ASC")
    @maritalStatuses = MaritalStatus.find(:all, :order => "name ASC")
    @genders = Gender.find(:all, :order => "name ASC")

    render :partial  => 'edit', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def edit
    @registration_information = @patient_data.registration_information
    @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    @races = Race.find(:all, :order => "name ASC")
    @ethnicities = Ethnicity.find(:all, :order => "name ASC")
    @religions = Religion.find(:all, :order => "name ASC")
    @maritalStatuses = MaritalStatus.find(:all, :order => "name ASC")
    @genders = Gender.find(:all, :order => "name ASC")
    render :partial  => 'edit', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def create
    @registration_information = RegistrationInformation.new(params[:registration_information])
    @patient_data.registration_information = @registration_information
    @registration_information.create_person_attributes(params)

    render :partial  => 'show', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def update
    @registration_information = @patient_data.registration_information
    @registration_information.update_attributes(params[:registration_information])
    @registration_information.update_person_attributes(params)
    render :partial  => 'show', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def destroy
    @registration_information = @patient_data.registration_information
    @registration_information.destroy
    render :partial  => 'show', :locals => {:registration_information =>  nil,
                                               :patient_data => @patient_data}
  end
  
end
