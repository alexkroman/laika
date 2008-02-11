class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :iso_language
      t.string :iso_country
      t.string :mode
      t.boolean :preference
      t.belongs_to :patient_data, :null => false
    end
  end

  def self.down
    drop_table :languages
  end
end
