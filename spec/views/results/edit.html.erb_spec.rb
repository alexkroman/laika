require File.dirname(__FILE__) + '/../../spec_helper'

describe "results/edit.html.erb" do
  fixtures :users

  before do
    assigns[:is_vital_sign] = true
  end

  describe "with an existing result (results/edit)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @result = Result.create!(:patient_data => @patient)
      assigns[:patient] = @patient
      assigns[:result] = @result
    end

    it "should render the edit form with method PUT" do
      render 'results/edit'
      response.should have_tag("form[action=#{patient_datum_result_path(@patient,@result, :is_vital_sign => true)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing result (results/new)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @result = Result.new
      assigns[:patient] = @patient
      assigns[:result] = @result
    end

    it "should render the edit form with method POST" do
      render 'results/edit'
      response.should have_tag("form[action=#{patient_datum_results_path(@patient, :is_vital_sign => true)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


