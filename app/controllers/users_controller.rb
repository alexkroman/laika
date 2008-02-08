class UsersController < ApplicationController

  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)
    @vendors = Vendor.find(:all)
  end
  
end
