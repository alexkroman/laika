class AdvanceDirectivesController < PatientDataChildController

  def new
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@advance_directive_types
      @advance_directive_types = AdvanceDirectiveType.find(:all, :order => "name ASC")
    end
    
    @advance_directive = AdvanceDirective.new
    
    @advance_directive.person_name = PersonName.new
    @advance_directive.address = Address.new
    @advance_directive.telecom = Telecom.new
    
    render :partial  => 'edit', :locals => {:advance_directive => @advance_directive,
                                            :patient_data => @patient_data}  
  end

  def edit
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@advance_directive_types
      @advance_directive_types = AdvanceDirectiveType.find(:all, :order => "name ASC")
    end
    
    @advance_directive = @patient_data.advance_directive
    
    unless @advance_directive.person_name
      @advance_directive.person_name = PersonName.new
    end
    unless @advance_directive.address
      @advance_directive.address = Address.new
    end
    unless @advance_directive.telecom
      @advance_directive.telecom = Telecom.new
    end
    
    render :partial  => 'edit', :locals => {:advance_directive => @advance_directive,
                                            :patient_data => @patient_data}
  end

  def create
    @advance_directive = AdvanceDirective.new(params[:advance_directive])
    @patient_data.advance_directive = @advance_directive
    @advance_directive.create_person_attributes(params)
    render :partial  => 'show', :locals => {:advance_directive => @advance_directive,
                                            :patient_data => @patient_data}
  end

  def update
    @advance_directive = @patient_data.advance_directive
    @advance_directive.update_attributes(params[:advance_directive])
    @advance_directive.update_person_attributes(params)
    render :partial  => 'show', :locals => {:advance_directive => @advance_directive,
                                            :patient_data => @patient_data}
  end

  def destroy
    @advance_directive = @patient_data.advance_directive
    @advance_directive.destroy
    render :partial  => 'show', :locals => {:advance_directive => nil,
                                                :patient_data => @patient_data}
  end
end
