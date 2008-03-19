class SupportsController < PatientDataChildController

  def new
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@contractTypes
      @contactTypes = ContactType.find(:all, :order => "name ASC")
    end
    if !@relationships
      @relationships = Relationship.find(:all, :order => "name ASC")
    end
    
    @support = Support.new
    @support.person_name = PersonName.new
    @support.address = Address.new
    @support.telecom = Telecom.new

    render :partial  => 'edit', :locals => {:support =>  @support,
                                            :patient_data => @patient_data}  
  end

  def edit
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@contractTypes
      @contactTypes = ContactType.find(:all, :order => "name ASC")
    end
    if !@relationships
      @relationships = Relationship.find(:all, :order => "name ASC")
    end
    
    @support = @patient_data.support
    
    render :partial  => 'edit', :locals => {:support =>  @support,
                                            :patient_data => @patient_data}
  end

  def create
    @support = Support.new(params[:support])
    @patient_data.support = @support
    @support.create_person_attributes(params)
    render :partial  => 'show', :locals => {:support =>  @support,
                                            :patient_data => @patient_data}
  end

  def update
    @support = @patient_data.support

    @support.update_attributes(params[:support])
    @support.update_person_attributes(params)

    render :partial  => 'show', :locals => {:support =>  @support,
                                            :patient_data => @patient_data}
  end

  def destroy
    @support = @patient_data.support
    @support.destroy
    render :partial  => 'show', :locals => {:support =>  nil,
                                                :patient_data => @patient_data}
                                                
  end
  
end
