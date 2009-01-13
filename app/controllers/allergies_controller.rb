class AllergiesController < PatientDataChildController
  
  # TODO: Need a way to nil out the end_event through the web ui

  def new
    @allergy = Allergy.new
    @patient_data.update_attribute(:no_known_allergies, false)
    
    render :partial => 'edit', :locals => {:allergy => @allergy,
                                           :patient_data => @patient_data}
  end

  def edit
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
