class ExpensesController < ApplicationController
  layout "dashboard", :except => [:edit]
  
  # Populating the accordion for the views
  before_filter :accordion, :only => [:new, :create, :update]
  
  
  # GET /expenses
  # GET /expenses.xml
  def index
    @expenses = current_user.expenses.sorted
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.xml
  def show
    @expense = current_user.expenses.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.xml
  def new
    @expense = current_user.expenses.new    
    @expense.date = session[:date] unless session[:date].blank?    
    @expenses = current_user.expenses.current
    @categories = Category.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = current_user.expenses.find(params[:id])    
    @categories = Category.all
    @selected = @expense.category.nil? ? nil : @expense.category.id
  end

  # POST /expenses
  # POST /expenses.xml
  def create
    params[:expense][:user_id] = current_user.id
    @expense = Expense.new(params[:expense])
    
    @expenses = current_user.expenses.sorted
    @categories = Category.all
    
    respond_to do |format|
      if @expense.save
        flash[:success] = t('activerecord.flash.created')
        format.html { redirect_to :action => "new" }
        format.xml  { render :xml => @expense, :status => :created, :location => @expense }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.xml
  def update
    @expense = current_user.expenses.find(params[:id])
    
    @expenses = current_user.expenses.sorted
    @categories = Category.all
    
    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        flash[:success] = t('activerecord.flash.updated')
        format.html { redirect_to :action => "new" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.xml
  def destroy
    @expense = current_user.expenses.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to :action => 'new' }
      format.xml  { head :ok }
    end
  end
  
  # Setting & removing fixed date inputs
  def fixed_date    
    set_fixed_date if params[:month]
    remove_fixed_date if params[:remove_date]
    render :partial => "shared/flash_messages", :locals => {:messages => [:success], :role => 'resource'}    
  end
  
  private
  
    # Generating items for accordion
    def accordion
      @current = current_user.expenses.current
      @today = current_user.expenses.today
      @yesterday = current_user.expenses.yesterday
      @before_yesterday = current_user.expenses.before_yesterday
    end
    
    # Fixing a date for batch input
    def set_fixed_date
      session[:date] = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      flash[:success] = t('activerecord.operations.category.fix_date_ok') + " #{session[:date].to_s}"
    end
  
    # Removing fixed date for batch input
    def remove_fixed_date
      session[:date] = nil
      flash[:success] = t('activerecord.operations.category.fix_date_ok') + " #{Date.today.to_s}"
    end
  
end
