class PatientIdentifier < ActiveRecord::Base

  strip_attributes!

  belongs_to :patient_data
  after_save { |r| r.patient_data.update_attributes(:updated_at => DateTime.now) }

  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}

  def requirements
    {
      :patient_data_id => :required,
      :identifier_domain_identifier => :required,
    }
  end

  def randomize()
    self.patient_identifier = rand(10 ** 10).to_s.rjust(10,'0')
    self.identifier_domain_identifier = "CCHIT&1.2.3.4.5.6.7.8.9&ISO"
  end
end
