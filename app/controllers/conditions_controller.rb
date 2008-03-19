class ConditionsController < PatientDataChildController
  
  # TODO: Need a way to nil out the end_event through the web ui

  def new
    
    if !@problem_types 
      @problem_types = ProblemType.find(:all)
    end
    
    @condition = Condition.new
    
    render :partial  => 'edit', :locals => {:condition => @condition,
                                            :patient_data => @patient_data}
  end

  def edit
    
    if !@problem_types 
      @problem_types = ProblemType.find(:all)
    end
    
    @condition = @patient_data.conditions.find(params[:id])
    
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
    render :partial  => 'delete.rjs'
    
  end
  
end
