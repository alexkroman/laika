class CreateVendorTestPlans < ActiveRecord::Migration
  def self.up
    create_table :vendor_test_plans do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :vendor_test_plans
  end
end
