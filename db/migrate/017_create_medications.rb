class CreateMedications < ActiveRecord::Migration
  def self.up
    create_table :medications do |t|
      t.string :product_coded_display_name
      t.string :product_code
      t.string :code_system_name
      t.string :code_system_code
      t.string :free_text_brand_name
      t.string :medication_type
      t.string :status
      t.float  :quantity_ordered_value
      t.string :quantity_ordered_unit
      t.string :prescription_number
      t.string :effectivetime
      
      t.belongs_to :patient_data, :null => false
    end
  end

  def self.down
    drop_table :medications
  end
end
