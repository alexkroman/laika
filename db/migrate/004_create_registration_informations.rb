class CreateRegistrationInformations < ActiveRecord::Migration
  def self.up
    create_table :registration_information do |t|
      t.string :person_identifier
      t.date :birth_date
      t.string :gender
      t.string :marital_status
      t.string :religious_affiliation
      t.string :race
      t.string :ethnicity
      t.string :home_phone
      t.string :work_phone
      t.string :mobile_phone
      t.string :vacation_home_phone
      t.string :email
      t.string :url
      t.belongs_to :patient_data, :null => false
    end
  end

  def self.down
    drop_table :registration_information
  end
end
