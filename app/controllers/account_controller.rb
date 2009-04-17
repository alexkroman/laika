class AccountController < ApplicationController
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  class InvalidPasswordResetCode < StandardError; end

  def index
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
      if current_user.vendor_test_plans.size == 0
        redirect_to patient_data_url
      else
        redirect_to vendor_test_plans_url
      end
      
    else
      flash[:notice] = %{
        Sorry mate, your email and password <strong>do not match</strong>.
        Want to <a href='#{relative_url_root}/account/signup' class='loginlink'>create an account?</a>
      }
      redirect_to :action => 'login'
    end
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    
    # user has no test plans on initial signup, go straight to patient data
    redirect_to patient_data_url
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default patient_data_url
  end
  
  def forgot_password
    return unless request.post?
    if @user = User.find_by_email(params[:email])
      @user.forgot_password
      @user.save
      flash[:notice] = "We found the email address #{params[:email]}, and just sent a password reset link"
      redirect_to :action => 'login'
    else
      flash[:notice] = "Sorry, we couldn't find email address <b>#{params[:email]}</b>" 
      redirect_to :action => 'forgot_password'
    end
  end
  
  def reset_password
    #logger.debug("password reset code is #{params[:id]}")
    @user = User.find_by_password_reset_code(params[:id]) if params[:id]
    raise InvalidPasswordResetCode if @user.nil?
    return if @user unless params[:password]
    if params[:password] == params[:password_confirmation]
      @user.password_confirmation = params[:password_confirmation]
      @user.password = params[:password]
      @user.reset_password
      if @user.save
        flash[:notice] = "Your Laika password has been reset"
        redirect_to :action => 'login'
      else
        @notice = "Your Laika password has not been reset" 
      end
    else
      @notice = "Password mismatch"
    end  
  rescue InvalidPasswordResetCode
    #logger.error "Invalid Reset Code entered" 
    flash[:notice] = "Sorry - That is an invalid password reset code.<P>Please check your code and try again.<P>(Perhaps your email client inserted a carriage return?"
    redirect_to :action => 'forgot_password'
  end  
  
end
