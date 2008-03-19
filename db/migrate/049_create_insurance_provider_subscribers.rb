class CreateInsuranceProviderSubscribers < ActiveRecord::Migration
  def self.up
    create_table :insurance_providers_subscribers do |t|
      t.date :date_of_birth
      t.belongs_to :insurance_providers, :null => false
    end
  end

  def self.down
    drop_table :insurance_providers_subscribers
  end
end
