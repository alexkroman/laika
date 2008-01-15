class CreateDocumentLocations < ActiveRecord::Migration
  def self.up
    create_table :document_locations do |t|
      t.string :name, :limit => 100
      t.string :xpath_expression, :limit => 400
      t.text :description
      t.string :doc_type, :limit => 10
      t.string :section, :limit => 30
    end
  end

  def self.down
    drop_table :document_locations
  end
end
