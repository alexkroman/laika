require File.dirname(__FILE__) + '/../../spec_helper'

describe "languages/edit.html.erb" do
  fixtures :users

  describe "with an existing language (languages/edit)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @language = Language.create!(:patient_data => @patient)
      assigns[:language]     = @language
      assigns[:patient_data] = @patient
    end

    it "should render the edit form with method PUT" do
      render 'languages/edit'
      response.should have_tag("form[action=#{patient_datum_language_path(@patient,@language)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing language (languages/new)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @language = Language.new
      assigns[:language]     = @language
      assigns[:patient_data] = @patient
    end

    it "should render the edit form with method POST" do
      render 'languages/edit'
      response.should have_tag("form[action=#{patient_datum_languages_path(@patient)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


