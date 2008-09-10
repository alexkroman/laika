class UserNotifier < ActionMailer::Base

  #def signup_notification(user)
  #  setup_email(user)
  #  @subject    += 'Please activate your new account'
  #  @body[:url]  = "http://YOURSITE/account/activate/#{user.activation_code}"
  #end
  
  #def activation(user)
  #  setup_email(user)
  #  @subject    += 'Your account has been activated!'
  #  @body[:url]  = "http://YOURSITE/"
  #end

  def forgot_password(user)
    setup_email(user)
    subject 'Request to change your Laika password'
    body :recipient => user.first_name, :url => "#{ENV['HOST_URL']}/account/reset_password/#{user.password_reset_code}" 
  end

  #protected
  #def setup_email(user)
  #  @recipients  = "#{user.email}"
  #  @from        = "ADMINEMAIL"
  #  @subject     = "[YOURSITE] "
  # @sent_on     = Time.now
  # @body[:user] = user
  #end

  protected

  def setup_email(user)
    recipients  "#{user.email}" 
    from "#{ENV['HELP_LIST']}"
    sent_on Time.now
  end

end
