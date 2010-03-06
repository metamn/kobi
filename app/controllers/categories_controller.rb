class CategoriesController < ApplicationController
  layout "dashboard", :except => [:edit]
  
  # getting all cats for index
  # getting all cats for selectbox on new, create, update
  before_filter :category_all, :only => [:index, :new, :create, :update]
  
  # setting current_user on create, update
  before_filter :set_current_user, :only => [:create, :update]
  
  # checking permissions
  before_filter :check_permission, :only => [:edit, :update, :destroy]
    
  
  # GET /categories
  # GET /categories.xml
  def index    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
    @categories = Category.all - [@category]
    @selected = @category.parent.nil? ? nil : @category.parent.id
  end

  # POST /categories
  # POST /categories.xml
  def create
    params[:category].delete(:ancestry) if params[:category][:ancestry] == ''    
    @category = Category.new(params[:category])        
    
    respond_to do |format|
      if @category.save
        flash[:success] = t('activerecord.flash.created')
        format.html { redirect_to :action => 'index' }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update    
    @category = Category.find(params[:id])            
    @selected = @category.parent.nil? ? nil : @category.parent.id
    
    if params[:category][:ancestry] == ''
      params[:category].delete(:ancestry)
      @category.ancestry = nil
    end    

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:success] = t('activerecord.flash.updated')
        format.html { redirect_to :action => 'index' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])    
    @category.destroy
    flash[:success] = t('activerecord.flash.deleted')
  
    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
  
  
  private
    
    def category_all
      @categories = Category.all
    end
    
    def set_current_user
      params[:category][:user_id] = current_user.id
    end
   
    def check_permission
      @item = Category.find(params[:id])
      if @item.user != current_user
        flash[:error] = t('activerecord.flash.not_allowed')
        redirect_to :action => "index" and return
      end
    end    
end
