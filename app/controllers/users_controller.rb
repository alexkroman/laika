class UsersController < ApplicationController

  # GET /users
  # GET /users.xml
  def index
    @vendors = User.find(:all)
  end
  
end
