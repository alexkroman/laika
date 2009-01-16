require File.dirname(__FILE__) + '/../../spec_helper'

describe "results/_edit.html.erb" do
  fixtures :users

  before do
    assigns[:is_vital_sign] = true
  end

  describe "with an existing result (results/edit)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @result = Result.create!(:patient_data => @patient_data)
    end

    it "should render the edit form with method PUT" do
      render :partial  => 'results/edit', :locals => {:result => @result,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_result_path(@patient_data,@result, :is_vital_sign => true)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing result (results/new)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @result = Result.new
    end

    it "should render the edit form with method POST" do
      render :partial  => 'results/edit', :locals => {:result => @result,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_results_path(@patient_data, :is_vital_sign => true)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


