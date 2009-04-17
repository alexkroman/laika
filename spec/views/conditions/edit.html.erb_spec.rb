require File.dirname(__FILE__) + '/../../spec_helper'

describe "conditions/edit.html.erb" do
  fixtures :users

  describe "with an existing condition (conditions/edit)" do
    before do
      @patient = Patient.create!(:name => 'foo', :user => User.find(:first))
      @condition = @patient.conditions.create!
      assigns[:condition] = @condition
      assigns[:patient] = @patient
    end

    it "should render the edit form with method PUT" do
      render 'conditions/edit'
      response.should have_tag("form[action=#{patient_condition_path(@patient,@condition)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing condition (conditions/new)" do
    before do
      @patient = Patient.create!(:name => 'foo', :user => User.find(:first))
      @condition = Condition.new
      assigns[:condition] = @condition
      assigns[:patient] = @patient
    end

    it "should render the edit form with method POST" do
      render 'conditions/edit'
      response.should have_tag("form[action=#{patient_conditions_path(@patient)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


