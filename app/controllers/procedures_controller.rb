class ProceduresController < PatientDataChildController

  def new    	
    @procedure = Procedure.new
    render :partial  => 'edit', :locals => {:procedure => @procedure,
                                            :patient_data => @patient_data}
  end

  def edit    
    @procedure = @patient_data.procedures.find(params[:id])
    render :partial  => 'edit', :locals => {:procedure => @procedure,
                                            :patient_data => @patient_data}
  end

  def create
    @procedure = Procedure.new(params[:procedure])
    @patient_data.procedures << @procedure
    render :partial  => 'create', :locals => {:procedure => @procedure,
                                              :patient_data => @patient_data}
  end

  def update
    @procedure = @patient_data.procedures.find(params[:id])
    @procedure.update_attributes(params[:procedure])
    render :partial  => 'show', :locals => {:procedure => @procedure,
                                            :patient_data => @patient_data}
  end

  # DELETE /procedures/1
  # DELETE /procedures/1.xml
  def destroy
    @procedure = @patient_data.procedures.find(params[:id])
    @procedure.destroy
    render :partial  => 'delete.rjs'
  end
  
end
