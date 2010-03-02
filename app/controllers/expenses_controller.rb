class ExpensesController < ApplicationController
  layout "dashboard", :except => [:edit]
  
  
  # GET /expenses
  # GET /expenses.xml
  def index
    @expenses = Expense.sorted
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.xml
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.xml
  def new
    @expense = Expense.new
    @expenses = Expense.sorted
    @categories = Category.roots
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])    
    @categories = Category.roots
  end

  # POST /expenses
  # POST /expenses.xml
  def create
    @expense = Expense.new(params[:expense])
    @expenses = Expense.sorted
    @categories = Category.roots
    
    respond_to do |format|
      if @expense.save
        flash[:notice] = t('activerecord.flash.created')
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
    @expense = Expense.find(params[:id])
    @expenses = Expense.sorted
    @categories = Category.roots
    
    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        flash[:notice] = t('activerecord.flash.updated')
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
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to :action => 'new' }
      format.xml  { head :ok }
    end
  end
end
