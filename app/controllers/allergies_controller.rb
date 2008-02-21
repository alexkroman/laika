class AllergiesController < PatientDataChildController
  def new
    @allergy = Allergy.new
    render :partial  => 'edit', :locals => {:allergy => @allergy,
                                            :patient_data => @patient_data}
  end

  def edit
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
