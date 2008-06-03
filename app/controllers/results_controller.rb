class ResultsController < PatientDataChildController

  def new
    unless @code_systems
      @code_systems = CodeSystem.find(:all, :order => "name DESC")
    end 
    
    @result = Result.new
    
    render :partial  => 'edit', :locals => {:result => @result,
                                            :patient_data => @patient_data}
  end

  def edit
    unless @code_systems
      @code_systems = CodeSystem.find(:all, :order => "name DESC")
    end 
    
    @result = @patient_data.results.find(params[:id])
    
    render :partial  => 'edit', :locals => {:result => @result,
                                            :patient_data => @patient_data}
  end

  def create
    @result = Result.new(params[:result])

    @patient_data.results << @result
    render :partial  => 'create', :locals => {:result => @result,
                                              :patient_data => @patient_data}
  end

  def update
    @result = @patient_data.results.find(params[:id])
    @result.update_attributes(params[:result])
    render :partial  => 'show', :locals => {:result => @result,
                                            :patient_data => @patient_data}
  end

  def destroy
    @result = @patient_data.results.find(params[:id])
    @result.destroy
    render :partial  => 'delete.rjs'
  end
end
