class AllergiesController < PatientDataChildController
  # TODO: Need a way to nil out the end_event through the web ui

  def new
    @allergy = Allergy.new
    @severity_terms = SeverityTerm.find(:all)
    @adverse_event_types = AdverseEventType.find(:all)
    render :partial  => 'edit', :locals => {:allergy => @allergy,
                                            :patient_data => @patient_data}
  end

  def edit
    @severity_terms = SeverityTerm.find(:all)
    @adverse_event_types = AdverseEventType.find(:all)
    @allergy = @patient_data.allergies.find(params[:id])
    render :partial  => 'edit', :locals => {:allergy => @allergy,
                                            :patient_data => @patient_data}
  end
  
  def create
    @allergy = Allergy.new(params[:allergy])
    @patient_data.allergies << @allergy
    render :partial  => 'create', :locals => {:allergy => @allergy,
                                              :patient_data => @patient_data}
  end
  
  def update
    @allergy = @patient_data.allergies.find(params[:id])
    @allergy.update_attributes(params[:allergy])
    
    render :partial  => 'show', :locals => {:allergy => @allergy,
                                            :patient_data => @patient_data}
  end
  
  def destroy
    @allergy = @patient_data.allergies.find(params[:id])
    @allergy.destroy
    redirect_to patient_data_url
  end
end
