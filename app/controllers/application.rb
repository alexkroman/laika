# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  VERSION_NUMBER = "0.2.1"

  helper :all # include all helpers, all the time
 
  include AuthenticatedSystem 
  
  before_filter :login_from_cookie
  before_filter :login_required, :except => [:login, :signup, :forgot_password, :reset_password]

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'dece9bb4d13101130349c3bef2c45b37'
  
end