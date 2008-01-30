class CreateSupports < ActiveRecord::Migration
  def self.up
    create_table :supports do |t|
      t.date :start_support
      t.date :end_support
      t.string :contact_relationship
      t.string :contact_type
      t.belongs_to :patient_data, :null => false
    end
  end

  def self.down
    drop_table :supports
  end
end
