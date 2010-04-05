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
  # before_filter :redirect_to_https
  

  
  # Common actions
  # -------------------------------
  
  # Updating a div with ""
  # - used to close a div via a Prototype AJAX call
  # - Example: closing an Update div when user clicks on "Back"
  def close
    render :text => ""
  end

  private
  
    # If not admin redirects to login
    def check_admin
      redirect_to destroy_session_path(current_user) unless is_admin?
    end
  
    # Force https to all pages
    def redirect_to_https
      redirect_to :protocol => "https://" unless (request.ssl? or local_request? or request.post? or ENV["RAILS_ENV"]=="development")   
    end
    
    # Redirecting users after signing in
    def after_sign_in_path_for(resource)
      flash[:permanent] = t('devise.confirmations.instructions') if current_user.confirmed_at.nil?
      new_expense_path
    end

end
