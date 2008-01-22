class CreateRegistrationInformations < ActiveRecord::Migration
  def self.up
    create_table :registration_information do |t|
      t.string :person_identifier
      t.string :name_prefix
      t.string :first_name
      t.string :last_name
      t.string :name_suffix
      t.date :birth_date
      t.string :gender
      t.string :marital_status
      t.string :religious_affiliation
      t.string :race
      t.string :ethnicity
      t.string :street_address_line_one
      t.string :street_address_line_two
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
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
