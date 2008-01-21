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
    laikaUser = User.new(
      :email => 'laika@mitre.org',
      :first_name => 'Laika',
      :last_name => 'DaDog',
      :password => 'laika',
      :password_confirmation => 'laika',
      :created_at => Time.now,
      :updated_at => Time.now,
      :terms_of_service => true,
      :send_updates => true
    )
    laikaUser.save!
  end  
   
  def self.down
  end
end
