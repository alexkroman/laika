class EncountersController < PatientDataChildController

  def edit
    @encounter = @patient.encounters.find(params[:id])
    
    unless @encounter.person_name
      @encounter.person_name = PersonName.new
    end
    unless @encounter.address
      @encounter.address = Address.new
    end
    unless @encounter.telecom
      @encounter.telecom = Telecom.new
    end
  end

  def create
    @encounter = Encounter.new(params[:encounter])
    @encounter.create_person_attributes(params)
    @patient.encounters << @encounter
  end

  def update
    encounter = @patient.encounters.find(params[:id])
    encounter.update_attributes(params[:encounter])
    encounter.update_person_attributes(params)
    render :partial  => 'show', :locals => {:encounter => encounter,
                                            :patient => @patient}
  end
end
