class CreateXpathExpressions < ActiveRecord::Migration
  def self.up
    create_table :xpath_expressions do |t|
      t.string :name
      t.string :expression
      t.string :doc_type
    end
    
    add_index :xpath_expressions, [:doc_type, :name]
  end

  def self.down
    drop_table :xpath_expressions
  end
end
