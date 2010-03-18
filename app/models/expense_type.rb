class ExpenseType < ActiveRecord::Base
  has_many :expenses
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^[\w\s]+$/i
  validates_format_of :description, :with => /^[\w\s]+$/i, :allow_nil => true, :allow_blank => true
end
