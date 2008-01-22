class UserRole < ActiveRecord::Base

  belongs_to :user, :foreign_key=>"user_id"
  belongs_to :role, :foreign_key=>"role_id"
  
end
