# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Temporarily checking if the user is admin
  def is_admin?
    current_user.email == "cs@clair.ro"    
  end
  
  # Checking if 'welcome' layout must be rendered
  def welcome_menu?    
    logger.info "wl ..... #{params[:controller]}"
    ret = ['welcome', 'registrations', 'sessions', 'passwords', 'confirmations'].include? params[:controller].to_s 
    logger.info "#{ret}"
    ret
  end
  
end
