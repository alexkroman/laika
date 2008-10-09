class MedicationsController < PatientDataChildController

  def new
    if !@medicationTypes
      @medicationTypes = MedicationType.find(:all, :order => "name ASC")
    end
    if !@medicationCodeSystems
      # Laika should provide only those code systems that are used by medications
      @medicationCodeSystems = CodeSystem.find_by_sql(
                                 "select * from code_systems " +
                                 "where code in (" + 
                                 "'2.16.840.1.113883.6.88', "  + # RxNorm
                                 "'2.16.840.1.113883.6.69', "  + # NDC
                                 "'2.16.840.1.113883.4.9', "   + # FDA Unique Ingredient ID (UNIII)
                                 "'2.16.840.1.113883.4.209') " + # NDF RT
                                 "order by name DESC")
    end 

    @medication = Medication.new
    render :partial  => 'edit', :locals => {:medication => @medication,
                                            :patient_data => @patient_data}
  end

  def edit
    if !@medicationTypes
      @medicationTypes = MedicationType.find(:all, :order => "name ASC")
    end
    if !@medicationCodeSystems
      @medicationCodeSystems = CodeSystem.find(:all, :order => "name DESC")
      # Laika should provide only those code systems that are used by medications
      @medicationCodeSystems = CodeSystem.find_by_sql(
                                 "select * from code_systems " +
                                 "where code in (" + 
                                 "'2.16.840.1.113883.6.88', "  + # RxNorm
                                 "'2.16.840.1.113883.6.69', "  + # NDC
                                 "'2.16.840.1.113883.4.9', "   + # FDA Unique Ingredient ID (UNIII)
                                 "'2.16.840.1.113883.4.209') " + # NDF RT
                                 "order by name DESC")
    end 

    @medication = @patient_data.medications.find(params[:id])
    render :partial  => 'edit', :locals => {:medication => @medication,
                                            :patient_data => @patient_data}
  end

  def create
    @medication = Medication.new(params[:medication])
    @patient_data.medications << @medication
    render :partial  => 'create', :locals => {:medication => @medication,
                                              :patient_data => @patient_data}
  end

  def update
    @medication = @patient_data.medications.find(params[:id])
    @medication.update_attributes(params[:medication])
    render :partial  => 'show', :locals => {:medication => @medication,
                                            :patient_data => @patient_data}
  end

  # DELETE /medications/1
  # DELETE /medications/1.xml
  def destroy
    @medication = @patient_data.medications.find(params[:id])
    @medication.destroy
    render :partial  => 'delete.rjs'
  end
end
