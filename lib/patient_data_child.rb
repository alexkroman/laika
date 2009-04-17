#
# This module is included by models that represent a subsection of a patient_data record.
#
module PatientDataChild
  def self.included(base)
    base.class_eval do
      belongs_to :patient, :foreign_key => :patient_data_id, :class_name => 'Patient'
      after_save { |r| r.patient.update_attributes(:updated_at => DateTime.now) }
    end
  end
end
