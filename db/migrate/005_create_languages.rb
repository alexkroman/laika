class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :language
      t.string :mode
      t.boolean :preference

      t.timestamps
    end
  end

  def self.down
    drop_table :languages
  end
end
