class PaymentMethodsController < ApplicationController
  include ApplicationHelper
  
  layout "resource"
  
  
  # checking permissions
  before_filter :check_permission, :only => [:edit, :update, :destroy]
  
  
  # GET /payment_methods
  # GET /payment_methods.xml
  def index
    @payment_methods = PaymentMethod.all
    @description = t('activerecord.models.description.payment_method')
      
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payment_methods }
    end
  end

  # GET /payment_methods/1
  # GET /payment_methods/1.xml
  def show
    @payment_method = PaymentMethod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment_method }
    end
  end

  # GET /payment_methods/new
  # GET /payment_methods/new.xml
  def new
    @payment_method = PaymentMethod.new
    @description = t('activerecord.operations.payment_method.new')

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payment_method }
    end
  end

  # GET /payment_methods/1/edit
  def edit
    @payment_method = PaymentMethod.find(params[:id])
    @description = t('activerecord.operations.payment_method.edit')
  end

  # POST /payment_methods
  # POST /payment_methods.xml
  def create
    @payment_method = PaymentMethod.new(params[:payment_method])

    respond_to do |format|
      if @payment_method.save
        flash[:success] = t('activerecord.flash.created')
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @payment_method, :status => :created, :location => @payment_method }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @payment_method.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /payment_methods/1
  # PUT /payment_methods/1.xml
  def update
    @payment_method = PaymentMethod.find(params[:id])

    respond_to do |format|
      if @payment_method.update_attributes(params[:payment_method])
        flash[:success] = t('activerecord.flash.updated')
        format.html { redirect_to :action => :index }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @payment_method.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_methods/1
  # DELETE /payment_methods/1.xml
  def destroy
    @payment_method = PaymentMethod.find(params[:id])
    @payment_method.destroy

    respond_to do |format|
      flash[:success] = t('activerecord.flash.deleted')
      format.html { redirect_to(payment_methods_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    def check_permission
      @item = PaymentMethod.find(params[:id])
      unless is_admin? 
        flash[:error] = t('activerecord.flash.not_allowed')
        redirect_to :back and return
      end
    end    
end
