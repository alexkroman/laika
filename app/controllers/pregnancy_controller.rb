class PregnancyController < PatientChildController

  def edit
    render :layout => false
  end

  def update
    @patient.pregnant = (params[:pregnant] == 'on')
    @patient.save!
    render :partial  => 'show'
  end
  
  def destroy
    @patient.pregnant = nil
    @patient.save!
    render :partial  => 'show'
  end

end
