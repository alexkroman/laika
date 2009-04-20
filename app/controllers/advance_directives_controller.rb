class AdvanceDirectivesController < PatientChildController
  def edit
    @advance_directive = @patient.advance_directive
  end

  def create
    advance_directive = AdvanceDirective.new(params[:advance_directive])
    @patient.advance_directive = advance_directive
    advance_directive.create_person_attributes(params)
    
    render :partial  => 'show', :locals => {:advance_directive => advance_directive, :patient => @patient}
  end

  def update
    advance_directive = @patient.advance_directive
    advance_directive.update_attributes(params[:advance_directive])
    advance_directive.update_person_attributes(params)
    
    render :partial  => 'show', :locals => {:advance_directive => advance_directive, :patient => @patient}
  end

  def destroy
    @patient.advance_directive.destroy
    render :partial  => 'show', :locals => {:advance_directive => nil, :patient => @patient}
  end
end
