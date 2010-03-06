class Category < ActiveRecord::Base
  belongs_to :user
  has_many :expenses

  validates_presence_of :name
  validates_uniqueness_of :name  
  validates_format_of :name, :with => /^[\w\s]+$/i

  validates_format_of :description, :with => /^[\w\s]+$/i, :allow_nil => true, :allow_blank => true
  validates_format_of :ancestry, :with => /^[\w\s]+$/i,  :allow_nil => true, :allow_blank => true
  
  named_scope :roots, :conditions => {:ancestry => nil}
  named_scope :sorted, :order => "name"
  
  
  def children
    Category.find :all, :conditions => {:ancestry => self.id.to_s}
  end
  
  def parent
    self.ancestry.nil? ? nil : Category.find(self.ancestry)
  end
  
  
end
