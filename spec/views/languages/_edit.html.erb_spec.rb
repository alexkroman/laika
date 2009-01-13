require File.dirname(__FILE__) + '/../../spec_helper'

describe "languages/_edit.html.erb" do
  fixtures :users

  before do
    IsoLanguage.stub!(:all).and_return([])
    IsoCountry.stub!(:all).and_return([])
    LanguageAbilityMode.stub!(:all).and_return([])
  end

  describe "with an existing language (languages/edit)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @language = Language.create!(:patient_data => @patient_data)
    end

    it "should render the edit form with method PUT" do
      render :partial  => 'languages/edit', :locals => {:language => @language,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_language_path(@patient_data,@language)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing language (languages/new)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @language = Language.new
    end

    it "should render the edit form with method POST" do
      render :partial  => 'languages/edit', :locals => {:language => @language,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_languages_path(@patient_data)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


