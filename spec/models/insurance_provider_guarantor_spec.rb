require File.dirname(__FILE__) + '/../spec_helper'

describe InsuranceProviderGuarantor do
  describe "with patient_data parent record" do
    fixtures :patient_data, :insurance_providers, :insurance_provider_guarantors,
      :addresses, :person_names, :telecoms

    before do
      @parent = patient_data(:joe_smith)
    end

    it "should update timestamp of parent on save" do
      old_stamp = @parent.updated_at
      @parent.insurance_provider_guarantors.first.save
      @parent.reload
      @parent.updated_at.should > old_stamp
    end

    %w[ address person_name telecom ].each do |attr|
      it "should update timestamp of parent on #{attr} save" do
        old_stamp = @parent.updated_at
        @parent.insurance_provider_guarantors.first.send(attr).save
        @parent.reload
        @parent.updated_at.should > old_stamp
      end
    end
  end
end

