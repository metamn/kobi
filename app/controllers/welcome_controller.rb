class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!
  
  
  def index    
    #redirect_to :controller => "sessions", :action => "new"    
  end

end
