class Category < ActiveRecord::Base
  has_ancestry
  
  has_many :expenses

  validates_presence_of :name
  validates_uniqueness_of :name  
  validates_format_of :name, :with => /^[\w\s]+$/i

  validates_format_of :description, :with => /^[\w\s]+$/i, :allow_nil => true, :allow_blank => true
  validates_format_of :ancestry, :with => /^[\w\s]+$/i,  :allow_nil => true, :allow_blank => true
end
