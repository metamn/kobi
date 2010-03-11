# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  # Authentication is manadatory for everybody 
  before_filter :authenticate_user!
  
  # Setting layouts
  layout "login"

  # Redirect to https
  before_filter :redirect_to_https
  



  # Common actions
  # -------------------------------
  
  # Updating a div with ""
  # - used to close a div via a Prototype AJAX call
  # - Example: closing an Update div when user clicks on "Back"
  def close
    render :text => ""
  end

  private
  
    def redirect_to_https
      redirect_to :protocol => "https://" unless (request.ssl? or local_request? or request.post? or ENV["RAILS_ENV"]=="development")   
    end
    
    def after_sign_in_path_for(resource)
      dashboard_path
    end

end
