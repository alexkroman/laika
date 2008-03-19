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
      
      # Either direct to the Dashboard or the Library, depending on if the user has vendor test plans
      @vendor_test_plans = self.current_user.vendor_test_plans
      numVendorTestPlans = @vendor_test_plans.size
      if numVendorTestPlans == 0
        redirect_to(:controller => '/patient_data', :action => 'index')
      else
        redirect_to(:controller => '/vendor_test_plans', :action => 'index')
      end
      
    end
    flash[:notice] = "Sorry mate, your email and password <b>don't match</b>.  Would you like to <a href='/account/signup'>create an account?</a>"
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    
    # Either direct to the Dashboard or the Library, depending on if the user has vendor test plans
      @vendor_test_plans = self.current_user.vendor_test_plans
      numVendorTestPlans = @vendor_test_plans.size
      if numVendorTestPlans == 0
        redirect_to(:controller => '/patient_data', :action => 'index')
      else
        redirect_to(:controller => '/vendor_test_plans', :action => 'index')
    end
    
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/patient_data', :action => 'index')
  end
  
  def forgot_password
    return unless request.post?
    if @user = User.find_by_email(params[:email])
      @user.forgot_password
      @user.save
      flash[:notice] = "We found the email address " + params[:email] + ", and just sent a password reset link"
    else
      flash[:notice] = "Sorry, we couldn't find email address <b>" + params[:email] + "</b>" 
    end
  end
  
  def reset_password
    #logger.debug("password reset code is #{params[:id]}")
    @user = User.find_by_password_reset_code(params[:id])
    raise if @user.nil?
    return if @user unless params[:password]
      if (params[:password] == params[:password_confirmation])
        self.current_user = @user #for the next two lines to work
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
        @user.reset_password
        flash[:notice] = current_user.save ? "Your Laika password has been reset" : "Your Laika password has not been reset" 
      else
        flash[:notice] = "Password mismatch" 
      end  
  rescue
    #logger.error "Invalid Reset Code entered" 
    flash[:notice] = "Sorry - That is an invalid password reset code.<P>Please check your code and try again.<P>(Perhaps your email client inserted a carriage return?"        
  end  
  
end
