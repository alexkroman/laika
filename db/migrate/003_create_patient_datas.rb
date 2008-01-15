class CreatePatientDatas < ActiveRecord::Migration
  def self.up
    create_table :patient_datas do |t|
      t.string :name
      t.belongs_to :vendor_test_plan
    end
  end

  def self.down
    drop_table :patient_datas
  end
end
