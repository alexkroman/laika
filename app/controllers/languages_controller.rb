class LanguagesController < PatientDataChildController
  def new
    
    if !@isoLanguages
      @isoLanguages = IsoLanguage.find(:all, :order => "name ASC")
    end
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@languageAbilityModes
      @languageAbilityModes = LanguageAbilityMode.find(:all, :order => "name ASC")
    end
  
    @language = Language.new
    
    render :partial  => 'edit', :locals => {:language => @language,
      :patient_data => @patient_data}
      
  end
  
  def edit
    
    if !@isoLanguages
      @isoLanguages = IsoLanguage.find(:all, :order => "name ASC")
    end
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@languageAbilityModes
      @languageAbilityModes = LanguageAbilityMode.find(:all, :order => "name ASC")
    end
    
    @language = @patient_data.languages.find(params[:id])
   
    render :partial  => 'edit', :locals => {:language => @language,
      :patient_data => @patient_data}
      
  end
  
  def create
    
    @language = Language.new(params[:language])
    @patient_data.languages << @language
    
    render :partial  => 'create', :locals => {:language => @language,
      :patient_data => @patient_data}
      
  end
  
  def update
    
    @language = @patient_data.languages.find(params[:id])
    @language.update_attributes(params[:language])
    
    render :partial  => 'show', :locals => {:language => @language,
      :patient_data => @patient_data}
  end
  
  def destroy
    @language = @patient_data.languages.find(params[:id])
    @language.destroy
    render :partial  => 'delete.rjs'
  end
end