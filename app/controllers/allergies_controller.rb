class AllergiesController < PatientDataChildController
  
  # TODO: Need a way to nil out the end_event through the web ui

  def new
    
    if !@severity_terms
      @severity_terms = SeverityTerm.find(:all, :order => "name ASC")
    end
    if !@adverse_event_types
      @adverse_event_types = AdverseEventType.find(:all, :order => "name ASC")
    end
    if !@allergy_status_codes
      @allergy_status_codes = AllergyStatusCode.find(:all, :order => "name ASC")
    end 
    if !@allergy_type_codes
       @allergy_type_codes = AllergyTypeCode.find(:all, :order => "name ASC")
    end
    
    @allergy = Allergy.new
    @patient_data.update_attribute(:no_known_allergies, false)
    
    render :partial => 'edit', :locals => {:allergy => @allergy,
                                           :patient_data => @patient_data}
  end

  def edit
    
    if !@severity_terms
      @severity_terms = SeverityTerm.find(:all, :order => "name ASC")
    end
    if !@adverse_event_types
      @adverse_event_types = AdverseEventType.find(:all, :order => "name ASC")
    end
    if !@allergy_status_codes
      @allergy_status_codes = AllergyStatusCode.find(:all, :order => "name ASC")
    end
    if !@allergy_type_codes
      @allergy_type_codes = AllergyTypeCode.find(:all, :order => "name ASC")
    end
    
    @allergy = @patient_data.allergies.find(params[:id])
    render :partial => 'edit', :locals => {:allergy => @allergy,
                                           :patient_data => @patient_data}
  end
  
  def create
    
    @allergy = Allergy.new(params[:allergy])
    @patient_data.allergies << @allergy
    @patient_data.update_attribute(:no_known_allergies, false)
    
    render :partial => 'create', :locals => {:allergy => @allergy,
                                              :patient_data => @patient_data}
  end
  
  def update
    
    @allergy = @patient_data.allergies.find(params[:id])
    @allergy.update_attributes(params[:allergy])
    
    render :partial => 'show', :locals => {:allergy => @allergy,
                                           :patient_data => @patient_data}
  end
  
  def destroy
    
    @allergy = @patient_data.allergies.find(params[:id])
    @allergy.destroy
    
    if @patient_data.allergies.empty?
      render :partial => "no_known_allergies_link", :locals=>{:patient_data=>@patient_data}
    else    
      render :partial => 'delete.rjs'
    end
    
  end
end
