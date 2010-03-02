class Expense < ActiveRecord::Base
  acts_as_taggable_on :tags   
  belongs_to :category
  
  named_scope :sorted, :order => "date DESC" 
  
  validates_presence_of :date, :amount
  validates_presence_of :category, :message => "nu poate sa fie gol. Va rugam creati mai intai categorii pentru cheltuieli"
  validates_date :date, :on_or_before => Date.today
  validates_numericality_of :amount
  validates_format_of :tags_saved, :with => /([a-zA-Z]+,)?[a-zA-Z]+/, :message => 'Numai caractere alfanumerice', :allow_nil => true, :allow_blank => true
end
