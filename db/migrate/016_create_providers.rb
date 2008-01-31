class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.date :start_service
      t.date :end_service
      t.string :role_code
      t.string :role_description
      t.string :organization
      t.string :patient_identifier
      t.belongs_to :patient_data, :null => false
    end
  end

  def self.down
    drop_table :providers
  end
end
