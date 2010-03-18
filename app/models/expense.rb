class Expense < ActiveRecord::Base
  acts_as_taggable_on :tags, :dependent => :nullify   
  belongs_to :category
  belongs_to :user
  belongs_to :payment_method
  belongs_to :expense_type
   
  
  validates_presence_of :date, :amount, :user, :category, :payment_method, :expense_type
  validates_presence_of :category, :message => "nu poate sa fie gol. Va rugam creati mai intai categorii pentru cheltuieli"
  validates_date :date, :on_or_before => Date.today
  validates_numericality_of :amount, :greater_than => 0
  validates_format_of :tag_list, :with => /([a-zA-Z]+,)?[a-zA-Z]+/, :message => 'Numai caractere alfanumerice', :allow_nil => true, :allow_blank => true
  
  default_scope :include => [:category], :order => 'date DESC'
  named_scope :current, :conditions => ["created_at >= ? OR updated_at >= ?", Date.today, Date.today], :order => 'updated_at DESC'
  named_scope :dated, lambda { |start_date, end_date|
    {:conditions => ["date >= ? AND date <= ?", start_date, end_date]}
  }
  named_scope :today, :conditions => ["date >= ? AND date < ?", Date.today, Date.tomorrow]
  named_scope :yesterday, :conditions => ["date >= ? AND date < ?", Date.yesterday, Date.today]
  named_scope :before_yesterday, :conditions => ["date >= ? AND date < ?", Date.yesterday-1, Date.yesterday]
  named_scope :this_week, :conditions => ["date >= ? AND date < ?", Date.today - Date.today.cwday, Date.tomorrow]
  named_scope :last_week, :conditions => ["date >= ? AND date < ?", Date.today - Date.today.cwday - 7, Date.today - Date.today.cwday]
  named_scope :this_month, :conditions => ["date >= ? AND date < ?", Date.today - Date.today.mday + 1, Date.tomorrow]
  
  
  # Amounts added up for a collection of Expenses 
  def self.suma
    sum('amount')
  end
end
