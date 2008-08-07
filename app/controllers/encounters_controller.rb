class EncountersController < PatientDataChildController

  def new
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@encounter_location_codes
      @encounter_location_codes = EncounterLocationCode.find(:all, :order => "name ASC")
    end
    if !@encounter_types
      @encounter_types = EncounterType.find(:all, :order => "name ASC")
    end
    
    @encounter = Encounter.new
    
    @encounter.person_name = PersonName.new
    @encounter.address = Address.new
    @encounter.telecom = Telecom.new
    
    render :partial  => 'edit', :locals => {:encounter => @encounter,
                                            :patient_data => @patient_data}
  end

  def edit
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@encounter_location_codes
      @encounter_location_codes = EncounterLocationCode.find(:all, :order => "name ASC")
    end
    if !@encounter_types
     @encounter_types = EncounterType.find(:all, :order => "name ASC")
    end
    
    @encounter = @patient_data.encounters.find(params[:id])
    
    unless @encounter.person_name
      @encounter.person_name = PersonName.new
    end
    unless @encounter.address
      @encounter.address = Address.new
    end
    unless @encounter.telecom
      @encounter.telecom = Telecom.new
    end
    
    render :partial  => 'edit', :locals => {:encounter => @encounter,
                                            :patient_data => @patient_data}
  end

  def create
    @encounter = Encounter.new(params[:encounter])
    @encounter.create_person_attributes(params)
    @patient_data.encounters << @encounter
    render :partial  => 'create', :locals => {:encounter => @encounter,
                                              :patient_data => @patient_data}
  end

  def update
    @encounter = @patient_data.encounters.find(params[:id])
    @encounter.update_attributes(params[:encounter])
    @encounter.update_person_attributes(params)
    render :partial  => 'show', :locals => {:encounter => @encounter,
                                            :patient_data => @patient_data}
  end

  # DELETE /encounters/1
  # DELETE /encounters/1.xml
  def destroy
    @encounter = @patient_data.encounters.find(params[:id])
    @encounter.destroy
    render :partial  => 'delete.rjs'
  end
end
