class AllergiesController < PatientDataChildController

  def create
    super
    @patient_data.update_attribute(:no_known_allergies, false)
  end
  
  def destroy
    super
    
    if @patient_data.allergies.empty?
      render :partial => "no_known_allergies_link", :locals=>{:patient_data=>@patient_data}
    end
  end
end
