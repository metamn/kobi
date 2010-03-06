# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Temporarily checking if the user is admin
  def is_admin?
    current_user.email == "cs@clair.ro"    
  end
  
end
