require File.dirname(__FILE__) + '/../../spec_helper'

describe "all allergy forms", :shared => true do
  it "should include severity information" do
    render 'allergies/edit'
    response.should have_tag("form") do
      with_tag "select[id=allergy_severity_term_id]"
    end
  end
end

describe "allergies/edit.html.erb" do
  fixtures :users

  describe "with an existing allergy (allergies/edit)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @allergy = @patient.allergies.create!
      assigns[:patient] = @patient
      assigns[:allergy] = @allergy
    end
    it_should_behave_like "all allergy forms"

    it "should render the edit form with method PUT" do
      render 'allergies/edit'
      response.should have_tag("form[action=#{patient_datum_allergy_path(assigns[:patient],assigns[:allergy])}]") do
        with_tag "input[name=_method][value=put]"
      end
    end

  end

  describe "without an existing allergy (allergies/new)" do
    before do
      assigns[:patient] = PatientData.create!(:name => 'foo', :user => User.find(:first))
      assigns[:allergy] = Allergy.new
    end
    it_should_behave_like "all allergy forms"

    it "should render the edit form with method POST" do
      render 'allergies/edit'
      response.should have_tag("form[action=#{patient_datum_allergies_path(assigns[:patient])}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


