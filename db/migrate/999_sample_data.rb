# Populates the Laika database with test data
class SampleData < ActiveRecord::Migration
  
  def self.up
    
    # All of the different roles in Laika
    vendorRole = Role.new(
      :name => 'Vendor'  
    )
    vendorRole.save!
    
    jurorRole = Role.new(
      :name => 'Juror'  
    )
    jurorRole.save!
    
    proctorRole = Role.new(
      :name => 'Proctor'  
    )
    proctorRole.save!
    
    administratorRole = Role.new(
      :name => 'Administrator'  
    )
    administratorRole.save!
    
    # Test users for Laika
    laikaUserMcCready = User.new(
      :email => 'rmccready@mitre.org',
      :first_name => 'Rob',
      :last_name => 'McCready',
      :password => 'laika',
      :password_confirmation => 'laika',
      :created_at => Time.now,
      :updated_at => Time.now,
      :terms_of_service => true,
      :send_updates => true
    )
    laikaUserMcCready.save!
    
    laikaUserMcCready.roles << administratorRole
    laikaUserMcCready.roles << jurorRole
    laikaUserMcCready.roles << proctorRole
    laikaUserMcCready.roles << administratorRole
    
  end  
   
  def self.down
  end
end
