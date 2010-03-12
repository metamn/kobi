class Category < ActiveRecord::Base
  belongs_to :user
  has_many :expenses

  validates_presence_of :name
  validates_uniqueness_of :name  
  validates_format_of :name, :with => /^[\w\s]+$/i

  validates_format_of :description, :with => /^[\w\s]+$/i, :allow_nil => true, :allow_blank => true
  validates_format_of :ancestry, :with => /^[\w\s]+$/i,  :allow_nil => true, :allow_blank => true
  
  named_scope :roots, :conditions => {:ancestry => nil}
  default_scope :order => "name"
  
  before_destroy {|record| Category.delete_all(:ancestry => record.id.to_s) }
  
  def children
    Category.find :all, :conditions => {:ancestry => self.id.to_s}
  end
  
  def parent
    self.ancestry.nil? ? nil : Category.find(self.ancestry)
  end
  
  # Returns those Categories who have childrens
  # - used in option_groups in select
  def self.has_children
    all.collect {|c| c unless c.children.blank?}.compact
  end
end
