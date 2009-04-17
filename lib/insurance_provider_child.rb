#
# This module is included by models that serve as sub-sections of InsuranceProvider.
#
# It adds the insurance_provider relationship and the named scope by_patient.
# It also updates the timestamp of insurance_provider.patient on save.
#
module InsuranceProviderChild
  def self.included(mod)
    mod.class_eval do
      belongs_to :insurance_provider
      named_scope :by_patient, lambda { |patient|
        {
          :include => :insurance_provider,
          :conditions => ['insurance_providers.patient_id = ?', patient.id]
        }
      }
      after_save { |r| r.insurance_provider.andand.patient.andand.update_attributes(:updated_at => DateTime.now) }

      # this is for the address, person_name, telecom after_save
      def patient
        insurance_provider.patient
      end
    end
  end
end
