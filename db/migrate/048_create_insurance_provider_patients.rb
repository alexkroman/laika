class CreateInsuranceProviderPatients < ActiveRecord::Migration
  def self.up
    create_table :insurance_providers_patients do |t|
      t.date :date_of_birth
      t.belongs_to :insurance_providers, :null => false
    end
  end

  def self.down
    drop_table :insurance_providers_patients
  end
end
