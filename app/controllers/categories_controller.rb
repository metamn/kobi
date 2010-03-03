class CategoriesController < ApplicationController
  layout "dashboard"
  
  
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.all

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
    @categories = Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
    @categories = Category.all - [@category]
  end

  # POST /categories
  # POST /categories.xml
  def create
    params[:category].delete(:ancestry) if params[:category][:ancestry] == ''
    @category = Category.new(params[:category])
    @categories = Category.all
    
    respond_to do |format|
      if @category.save
        flash[:notice] = t('activerecord.flash.created')
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
    @categories = Category.all
    
    if params[:category][:ancestry] == ''
      params[:category].delete(:ancestry)
      @category.ancestry = nil
    end

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = t('activerecord.flash.updated')
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
    if is_admin? 
      @category = Category.find(params[:id])
      @category.destroy
    else
      flash[:notice] = t('activerecord.flash.not_allowed')
    end

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end
