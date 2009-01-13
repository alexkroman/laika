require File.dirname(__FILE__) + '/../../spec_helper'

describe "procedure/_edit.html.erb" do
  fixtures :users

  describe "with an existing procedure (procedures/edit)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @procedure = Procedure.create!(:patient_data => @patient_data)
    end

    it "should render the edit form with method PUT" do
      render :partial  => 'procedures/edit', :locals => {:procedure => @procedure,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_procedure_path(@patient_data,@procedure)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing procedure (procedures/new)" do
    before do
      @patient_data = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @procedure = Procedure.new
    end

    it "should render the edit form with method POST" do
      render :partial  => 'procedures/edit', :locals => {:procedure => @procedure,
                                                         :patient_data => @patient_data}
      response.should have_tag("form[action=#{patient_data_instance_procedures_path(@patient_data)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


