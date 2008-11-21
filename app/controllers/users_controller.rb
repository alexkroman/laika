class UsersController < ApplicationController

  before_filter :find_user, :except => [:index]

  def index
    @users = User.find(:all)
    @vendors = Vendor.find(:all)
  end

  def edit
  end

  def destroy
    if not current_user.administrator?
      flash[:notice] = "Only administrators are permitted to perform this action."
      redirect_to :controller => 'patient_data', :action => 'index'
    elsif current_user == @user
      flash[:notice] = "You cannot delete your own account."
      redirect_to :action => 'index'
    else
      @user.destroy
      flash[:notice] = "#{@user.display_name} has been deleted."
      redirect_to :action => 'index'
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your settings have been saved."
      redirect_to edit_user_path(@user)
    else
      render :action => 'edit'
    end
  end

  private

  def find_user
    @user = current_user.administrator? ? User.find(params[:id]) : current_user
  end
  
end
