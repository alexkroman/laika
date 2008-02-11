class CreateVendorTestPlans < ActiveRecord::Migration
  def self.up
    create_table :vendor_test_plans do |t|
      t.belongs_to :vendor
      t.string :kind
      t.column :errors, :int
      t.column :compliance, :double
      t.timestamps
    end
  end

  def self.down
    drop_table :vendor_test_plans
  end
end
