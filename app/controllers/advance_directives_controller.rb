class AdvanceDirectivesController < PatientDataChildController
  layout false

  def new
    @advance_directive = AdvanceDirective.new
    render :action => 'edit'
  end

  def edit
    @advance_directive = @patient_data.advance_directive
    
    @advance_directive.person_name ||= PersonName.new
    @advance_directive.address     ||= Address.new
    @advance_directive.telecom     ||= Telecom.new
  end

  def create
    @advance_directive = AdvanceDirective.new(params[:advance_directive])
    @patient_data.advance_directive = @advance_directive
    @advance_directive.create_person_attributes(params)
    
    render :action  => 'show'
  end

  def update
    @advance_directive = @patient_data.advance_directive
    @advance_directive.update_attributes(params[:advance_directive])
    @advance_directive.update_person_attributes(params)
    
    render :action  => 'show'
  end

  def destroy
    @patient_data.advance_directive.destroy
    render :action  => 'show'
  end
end
