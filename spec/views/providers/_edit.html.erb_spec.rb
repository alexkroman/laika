require File.dirname(__FILE__) + '/../../spec_helper'

describe "providers/_edit.html.erb" do
  fixtures :users

  describe "with an existing provider (providers/edit)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @provider = Provider.create!(:patient_data => @patient_data)
    end

    it "should render the edit form with method PUT" do
      render :partial  => 'providers/edit', :locals => {:provider => @provider,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_provider_path(@patient_data,@provider)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing provider (providers/new)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @provider = Provider.new
    end

    it "should render the edit form with method POST" do
      render :partial  => 'providers/edit', :locals => {:provider => @provider,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_providers_path(@patient_data)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


