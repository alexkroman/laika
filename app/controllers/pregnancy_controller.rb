class PregnancyController < PatientDataChildController

  def edit
    render :layout => false
  end

  def update
    @patient_data.pregnant = (params[:pregnant] == 'on')
    @patient_data.save!
    render :partial  => 'show'
  end
  
  def destroy
    @patient_data.pregnant = nil
    @patient_data.save!
    render :partial  => 'show'
  end

end
