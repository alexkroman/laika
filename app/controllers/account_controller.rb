class AccountController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  def index
    redirect_to(:action => 'login') unless logged_in? || User.count > 0
  end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:email], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => '/vendor_test_plans', :action => 'index')
      flash[:notice] = "Logged in successfully"
    end
    flash[:notice] = "Sorry mate, your email and password <b>don't match</b>.  Would you like to <a href='/account/signup'>create an account?</a>"
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/vendor_test_plans', :action => 'index')
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/vendor_test_plans', :action => 'index')
  end
  
  def forgot_password
    return unless request.post?
    if @user = User.find_by_email(params[:email])
      #@user.forgot_password
      #@user.save
      flash[:notice] = "We found " + params[:email] + ", and just sent a password reset link"
    else
      flash[:notice] = "Sorry, we couldn't find email address <b>" + params[:email] + "</b>" 
    end
  end
end
