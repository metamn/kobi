class AdminController < ApplicationController
  include ApplicationHelper
  
  layout "resource"
  
  before_filter :check_admin
  
  def users
    @description = "Users"
    @users = User.with_eager_loading.order_by_date.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
end
