class ConditionsController < PatientDataChildController
  
  # TODO: Need a way to nil out the end_event through the web ui

  def new
    @condition = Condition.new
    @problem_types = ProblemType.find(:all)
    render :partial  => 'edit', :locals => {:condition => @condition,
                                            :patient_data => @patient_data}
  end

  def edit
    @condition = @patient_data.conditions.find(params[:id])
    @problem_types = ProblemType.find(:all)
    render :partial  => 'edit', :locals => {:condition => @condition,
                                            :patient_data => @patient_data}
  end
  
  def create
    @condition = Condition.new(params[:condition])
    @patient_data.conditions << @condition
    render :partial  => 'create', :locals => {:condition => @condition,
                                              :patient_data => @patient_data}
  end
  
  def update
    @condition = @patient_data.conditions.find(params[:id])
    @condition.update_attributes(params[:condition])
    render :partial  => 'show', :locals => {:condition => @condition,
                                            :patient_data => @patient_data}
  end
  
  def destroy
    @condition = @patient_data.conditions.find(params[:id])
    @condition.destroy
    redirect_to patient_data_url
  end
end
