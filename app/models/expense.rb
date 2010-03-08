class Expense < ActiveRecord::Base
  acts_as_taggable_on :tags   
  belongs_to :category
  belongs_to :user
   
  
  validates_presence_of :date, :amount
  validates_presence_of :category, :message => "nu poate sa fie gol. Va rugam creati mai intai categorii pentru cheltuieli"
  validates_date :date, :on_or_before => Date.today
  validates_numericality_of :amount
  validates_format_of :tag_list, :with => /([a-zA-Z]+,)?[a-zA-Z]+/, :message => 'Numai caractere alfanumerice', :allow_nil => true, :allow_blank => true
  
  named_scope :sorted, :order => "date DESC" 
  named_scope :current, :conditions => ["created_at >= ? OR updated_at >= ?", Date.today, Date.today]
  named_scope :dated, lambda { |start_date, end_date|
    {:conditions => ["date >= ? AND date <= ?", start_date, end_date]}
  }
  named_scope :today, :conditions => ["date >= ? AND date < ?", Date.today, Date.tomorrow]
  named_scope :yesterday, :conditions => ["date >= ? AND date < ?", Date.yesterday, Date.today]
  named_scope :before_yesterday, :conditions => ["date >= ? AND date < ?", Date.yesterday-1, Date.yesterday]
end
