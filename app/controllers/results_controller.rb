# This controller handles both Results and VitalSigns. Since VitalSigns and
# Results are both AbstractResults, this works out pretty cleanly. The only place where
# things get tricky is in the create method. Other than that, they can both
# be treated as results and reuse the same views.
class ResultsController < PatientDataChildController

  def new
    @is_vital_sign = params[:is_vital_sign]
    @result = Result.new
    render :action => 'edit'
  end

  def edit
    @is_vital_sign = params[:is_vital_sign]
    @result = @patient_data.all_results.find(params[:id])
  end

  # Create will make a new Result or VitalSign record. They both use the exact
  # same form. When the Ajax is executed to create the form for a new VitalSign
  # there is a callback at the end which puts a "type" hidden field in the form
  # indicating it is a VitalSign so we can create the correct record.
  def create
    if params[:type] == 'vital'
      @result = VitalSign.new(params[:result])
    else
      @result = Result.new(params[:result])
    end

    @patient_data.all_results << @result
  end

  def update
    result = @patient_data.all_results.find(params[:id])
    result.update_attributes(params[:result])
    render :partial  => 'show', :locals => {:result => result,
                                            :patient_data => @patient_data}
  end

  def destroy
    result = @patient_data.all_results.find(params[:id])
    result.destroy
  end

end
