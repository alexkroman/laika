require File.dirname(__FILE__) + '/../../spec_helper'

describe "insurance_providers/edit.html.erb" do
  fixtures :users

  describe "with an existing insurance_provider (insurance_providers/edit)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @insurance_provider = InsuranceProvider.create!(:patient_data => @patient)
      @insurance_provider.insurance_provider_patient = InsuranceProviderPatient.new
      @insurance_provider.insurance_provider_patient.person_name = PersonName.new
      @insurance_provider.insurance_provider_patient.address = Address.new
      @insurance_provider.insurance_provider_patient.telecom = Telecom.new
      @insurance_provider_patient = @insurance_provider.insurance_provider_patient

      @insurance_provider.insurance_provider_subscriber = InsuranceProviderSubscriber.new
      @insurance_provider.insurance_provider_subscriber.person_name = PersonName.new
      @insurance_provider.insurance_provider_subscriber.address = Address.new
      @insurance_provider.insurance_provider_subscriber.telecom = Telecom.new
      @insurance_provider_subscriber = @insurance_provider.insurance_provider_subscriber

      @insurance_provider.insurance_provider_guarantor = InsuranceProviderGuarantor.new
      @insurance_provider.insurance_provider_guarantor.person_name = PersonName.new
      @insurance_provider.insurance_provider_guarantor.address = Address.new
      @insurance_provider.insurance_provider_guarantor.telecom = Telecom.new
      @insurance_provider_guarantor = @insurance_provider.insurance_provider_guarantor
      @insurance_provider.save!
      assigns[:patient] = @patient
      assigns[:insurance_provider] = @insurance_provider
    end

    it "should render the edit form with method PUT" do
      render 'insurance_providers/edit'
      response.should have_tag("form[action=#{patient_datum_insurance_provider_path(@patient,@insurance_provider)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing insurance_provider (insurance_providers/new)" do
    before do
      @patient = PatientData.create!(:name => 'foo', :user => User.find(:first))
      @insurance_provider = InsuranceProvider.new
      @insurance_provider.insurance_provider_patient = InsuranceProviderPatient.new
      @insurance_provider.insurance_provider_patient.person_name = PersonName.new
      @insurance_provider.insurance_provider_patient.address = Address.new
      @insurance_provider.insurance_provider_patient.telecom = Telecom.new
      @insurance_provider_patient = @insurance_provider.insurance_provider_patient

      @insurance_provider.insurance_provider_subscriber = InsuranceProviderSubscriber.new
      @insurance_provider.insurance_provider_subscriber.person_name = PersonName.new
      @insurance_provider.insurance_provider_subscriber.address = Address.new
      @insurance_provider.insurance_provider_subscriber.telecom = Telecom.new
      @insurance_provider_subscriber = @insurance_provider.insurance_provider_subscriber

      @insurance_provider.insurance_provider_guarantor = InsuranceProviderGuarantor.new
      @insurance_provider.insurance_provider_guarantor.person_name = PersonName.new
      @insurance_provider.insurance_provider_guarantor.address = Address.new
      @insurance_provider.insurance_provider_guarantor.telecom = Telecom.new
      @insurance_provider_guarantor = @insurance_provider.insurance_provider_guarantor
      assigns[:patient] = @patient
      assigns[:insurance_provider] = @insurance_provider
    end

    it "should render the edit form with method POST" do
      render 'insurance_providers/edit'
      response.should have_tag("form[action=#{patient_datum_insurance_providers_path(@patient)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


