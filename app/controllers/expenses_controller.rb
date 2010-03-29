class ExpensesController < ApplicationController
  layout 'resource', :except => [:edit]
    
  # Populating the views
  before_filter :accordion, :only => [:new, :create, :update]
  before_filter :relations, :only => [:new, :edit, :create, :update]
  
  # GET /expenses
  # GET /expenses.xml
  def index
    convert_date if (params[:search] && params[:search]['date_lte(1i)'])
    @search = current_user.expenses.search(params[:search]) 
    @expenses = @search.all.uniq
    # TODO Count does not working in HEroku
    #@count = @expenses.count
    @sum = @expenses.inject(0){|sum, item| sum + item.amount}
    @categories = Category.all
    @tags = current_user.owned_tags
    @expense_types = ExpenseType.all
    @payment_method = PaymentMethod.all
    
    @description = t('menu.expenses.index.description') 
    @single_column = true
    
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
    remove_fixed_date if params[:remove_date]
    @expense.date = session[:date] unless session[:date].blank?  
    
    @description = t('menu.expenses.new.description')   
        
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = current_user.expenses.find(params[:id])
    @divid = params[:divid] || divid
    @selected = @expense.category.nil? ? nil : @expense.category
    
    # edit/update is an ajax call, it will be managed through rjs, where on errors 'edit' partial is reloaded
    # so we need '_edit' instead of 'edit' here
    render :partial => 'edit'
  end

  # POST /expenses
  # POST /expenses.xml
  def create
    params[:expense][:user_id] = current_user.id
    check_subcats
    @expense = Expense.new(params[:expense])
    
    respond_to do |format|
      if @expense.save
        # Attaching tags to the current user
        add_tags_to_current_user(@expense) unless params[:expense][:tag_list].blank?
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
    get_divid_to_close
    
    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        # Attaching tags to the current user
        add_tags_to_current_user(@expense) unless params[:expense][:tag_list].blank?
        flash[:success] = t('activerecord.flash.updated')
        format.html { redirect_to :back }
        format.xml  { head :ok } 
        format.js 
      else
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }        
        format.js
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.xml
  def destroy
    @expense = current_user.expenses.find(params[:id])
    @expense.destroy

    respond_to do |format|
      flash[:success] = t('activerecord.flash.deleted')
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
  # Additional Ajax calls
  # ---------------------
  
  # Setting & removing fixed date inputs
  def fixed_date    
    set_fixed_date if params[:month]     
  end
  
  # Closing an update div
  def close
    @divid = params[:divid]
    @id = params[:id]    
    
    respond_to do |format|
      format.js
    end 
  end
  
  
  
  private
  
    # Checking if there are subcats selected
    # - from a cat and many subcats just the last subcat will be used
    def check_subcats
      for i in 1..50
        catid = "category_id_#{i}".to_sym
        if params[:expense][catid]  
          params[:expense][:category_id] = params[:expense][catid] unless params[:expense][catid] == "" 
          params[:expense].delete catid
        else
          break
        end 
      end      
    end
    
    # Getting which div to close with Ajax (on updating expense)
    def get_divid_to_close
      @divid = params[:expense][:divid]
      params[:expense].delete('divid')
      @close = "ajax-update-#{@divid}-#{@expense.id}"
      @update = "update-#{@divid}-#{@expense.id}"
    end
  
    # Expense tags are associated with the current user
    def add_tags_to_current_user(expense)
      current_user.tag(expense, :with => params[:expense][:tag_list], :on => :tags)         
    end
    
    # Combines date_select params into a text_field for Searchlogic
    def convert_date
      params[:search][:date_lte] = params[:search]['date_lte(1i)'].to_s + "-" + params[:search]['date_lte(2i)'].to_s + "-" + params[:search]['date_lte(3i)'].to_s
      params[:search][:date_gte] = params[:search]['date_gte(1i)'].to_s + "-" + params[:search]['date_gte(2i)'].to_s + "-" + params[:search]['date_gte(3i)'].to_s
      ['date_lte(1i)', 'date_lte(2i)', 'date_lte(3i)', 'date_gte(1i)', 'date_gte(2i)', 'date_gte(3i)'].each do |d|
        params[:search].delete(d)
      end      
    end
  
    # Getting categories, expense types, payment methods
    def relations      
      @roots = Category.roots  
      @categories = Category.has_children    
      @expense_types = ExpenseType.all
      @payment_methods = PaymentMethod.all
    end
  
    # Generating items for accordion
    def accordion
      @current = current_user.expenses.current
      @today = current_user.expenses.today.order_by_date
      @yesterday = current_user.expenses.yesterday.order_by_date
      @before_yesterday = current_user.expenses.before_yesterday.order_by_date
      @this_week = current_user.expenses.this_week.order_by_date
      @last_week = current_user.expenses.last_week.order_by_date
      @this_month = current_user.expenses.this_month.order_by_date 
      
      @accordion_items = [
        [t('date.today'), @today, @today.suma],
        [t('date.yesterday'), @yesterday, @yesterday.suma],
        [t('date.before_yesterday'), @before_yesterday, @before_yesterday.suma],
        [t('date.this_week'), @this_week, @this_week.suma],
        [t('date.last_week'), @last_week, @last_week.suma], 
        [t('date.this_month'), @this_month, @this_month.suma]
      ]          
    end
    
    # Fixing a date for batch input
    def set_fixed_date
      session[:date] = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      flash[:success] = t('activerecord.operations.category.fix_date_ok') + " #{l(session[:date]).to_s}"      
    end
  
    # Removing fixed date for batch input
    def remove_fixed_date
      session[:date] = nil
      flash[:success] = t('activerecord.operations.category.fix_date_ok') + " #{l(Date.today).to_s}"
    end
  
end
