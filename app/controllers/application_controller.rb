# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  # Authentication is manadatory for everybody => Login page is the main page
  before_filter :authenticate_user!
  
  # Setting layouts
  layout "login"

  # Temporarily checking if the user is admin
  def check_admin
    return if current_user.email == "cs@clair.ro"
    flash[:notice] = "Sectiune accesibila numai pentru administratori"
    redirect_to root_path
  end
end
