class TemplateInformationController < PatientDataChildController
  before_filter :set_template_information

  def edit
    render :partial  => 'edit', :locals => { :template_information => @patient_data }
  end

  def update
    if @patient_data.update_attributes(params[:template_information])
      render :partial => 'show', :locals => { :template_information => @patient_data }
    else
      render :partial => 'edit', :locals => { :template_information => @patient_data }
    end
  end

  def destroy
  end

  protected

  def set_template_information
    @patient_data = PatientData.find(params[:id])
  end
  
end
