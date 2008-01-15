class CreateNamespaces < ActiveRecord::Migration
  def self.up
    create_table :namespaces do |t|
      t.string :prefix
      t.string :uri
      t.belongs_to :document_location, :null => false
    end
  end

  def self.down
    drop_table :namespaces
  end
end
