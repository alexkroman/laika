#
# This module is included by models that serve as sub-sections of InsuranceProvider.
#
# It adds the insurance_provider relationship and the named scope by_patient(patient_data).
#
module InsuranceProviderChild
  def self.included(mod)
    mod.belongs_to :insurance_provider
    mod.named_scope :by_patient, lambda { |patient|
      {
        :include => :insurance_provider,
        :conditions => ['insurance_providers.patient_data_id = ?', patient.id]
      }
    }
    mod.after_save { |r| r.insurance_provider.patient_data.update_attributes(:updated_at => DateTime.now) }
  end
end
