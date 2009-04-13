require File.dirname(__FILE__) + '/../spec_helper'

describe InsuranceProviderPatient do
  describe "with patient_data parent record" do
    fixtures :patient_data, :insurance_providers, :insurance_provider_patients
    before do
      @parent = patient_data(:joe_smith)
    end

    it "should update timestamp of parent on save" do
      old_stamp = @parent.updated_at
      @parent.insurance_provider_patients.first.save
      @parent.reload
      @parent.updated_at.should > old_stamp
    end
  end
end
