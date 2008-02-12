class LanguagesController < PatientDataChildController
  def new
    @isoLanguages = IsoLanguage.find(:all, :order => "name ASC")
    @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    @languageAbilityModes = LanguageAbilityMode.find(:all, :order => "name ASC")
    @language = Language.new
    render :partial  => 'edit', :locals => {:language => @language,
                                            :patient_data => @patient_data}
  end

  def edit
    @isoLanguages = IsoLanguage.find(:all, :order => "name ASC")
    @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    @languageAbilityModes = LanguageAbilityMode.find(:all, :order => "name ASC")
    @language = @patient_data.languages.find(params[:id])
    render :partial  => 'edit', :locals => {:language => @language,
                                            :patient_data => @patient_data}
  end

  def create
    
    # find the associated meta-data
    isoLanguage = IsoLanguage.find(params[:iso_language_id])
    isoCountry = IsoCountry.find(params[:iso_country_id])
    languageAbilityMode = LanguageAbilityMode.find(params[:language_ability_mode_id])
    
    @language = Language.new(:iso_language => isoLanguage, :iso_country => isoCountry, :language_ability_mode => languageAbilityMode)
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
    redirect_to patient_data_url
  end
end