# This controller handles both Results and VitalSigns. Since VitalSigns are
# a subclass of Results, this works out pretty cleanly. The only place where
# things get tricky is in the create method. Other than that, they can both
# be treated as results and reuse the same views.
class ResultsController < PatientDataChildController

  def new

    @is_vital_sign = params[:is_vital_sign]

    unless @code_systems
      @code_systems = CodeSystem.find(:all, :order => "name DESC")
    end
    unless @act_status_codes
      @act_status_codes = ActStatusCode.find(:all, :order => "name DESC")
    end
    unless @result_type_codes
      @result_type_codes = ResultTypeCode.find(:all, :order => "name DESC")
    end
    unless @loinc_lab_codes
      @loinc_lab_codes = LoincLabCode.find(:all, :order => "name ASC")
    end

    @result = Result.new

    render :partial  => 'edit', :locals => {:result => @result,
                                            :patient_data => @patient_data}
  end

  def edit

    @is_vital_sign = params[:is_vital_sign]

    unless @code_systems
      @code_systems = CodeSystem.find(:all, :order => "name DESC")
    end
    unless @act_status_codes
      @act_status_codes = ActStatusCode.find(:all, :order => "name DESC")
    end
    unless @result_type_codes
      @result_type_codes = ResultTypeCode.find(:all, :order => "name DESC")
    end
    unless @loinc_lab_codes
      @loinc_lab_codes = LoincLabCode.find(:all, :order => "name ASC")
    end

    @result = @patient_data.results.find(params[:id])

    render :partial  => 'edit', :locals => {:result => @result,
                                            :patient_data => @patient_data}
  end

  # Create will make a new Result or VitalSign record. They both use the exact
  # same form. When the Ajax is executed to create the form for a new VitalSign
  # there is a callback at the end which puts a "type" hidden field in the form
  # indicating it is a VitalSign so we can create the correct record.
  def create

    if 'vital'.eql? params[:type]
      @result = VitalSign.new(params[:result])
    else
      @result = Result.new(params[:result])
      @result.type = 'Result' # AR's STI doesn't set this for us... not sure why
    end

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
