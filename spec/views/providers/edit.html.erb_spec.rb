require File.dirname(__FILE__) + '/../../spec_helper'

describe "providers/edit.html.erb" do
  fixtures :users

  describe "with an existing provider (providers/edit)" do
    before do
      @patient = Patient.create!(:name => 'foo', :user => User.find(:first))
      @provider = @patient.providers.create!
      assigns[:patient] = @patient
      assigns[:provider] = @provider
    end

    it "should render the edit form with method PUT" do
      render 'providers/edit'
      response.should have_tag("form[action=#{patient_datum_provider_path(@patient,@provider)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing provider (providers/new)" do
    before do
      @patient = Patient.create!(:name => 'foo', :user => User.find(:first))
      @provider = Provider.new
      assigns[:patient] = @patient
      assigns[:provider] = @provider
    end

    it "should render the edit form with method POST" do
      render 'providers/edit'
      response.should have_tag("form[action=#{patient_datum_providers_path(@patient)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


