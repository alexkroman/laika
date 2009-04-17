require File.dirname(__FILE__) + '/../spec_helper'

describe Commentable do
  %w[
    Immunization AbstractResult Allergy Medication Encounter
    Condition InsuranceProvider Provider AdvanceDirective
  ].each do |class_name|
    it "should be included by #{class_name}" do
      class_name.constantize.include?(Commentable).should be_true
    end
  end

  # Since this is an activerecord extension, I'm using an exsting model type.
  # We're only testing commentable functionality here, not immunization.
  describe "with an example immunization" do
    fixtures :patients
    before do
      @patient = Patient.first
      @immunization = @patient.immunizations.create
      @comment = @immunization.create_comment(:text => 'yo dawg.')
    end

    it "should copy the comment on clone" do
      copy = @immunization.clone
      copy.comment.should_not == @comment
      copy.comment.text.should == @comment.text
    end

    it "should delete the comment on destroy" do
      @immunization.destroy
      lambda { @comment.reload }.should raise_error(ActiveRecord::RecordNotFound)
    end

    it "should touch the patient timestamp on comment save" do
      last_updated_at = @patient.updated_at
      @comment.save
      @patient.reload
      @patient.updated_at.should > last_updated_at
    end
  end
end

