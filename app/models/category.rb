class Category < ActiveRecord::Base
  has_ancestry
  
  has_many :expenses
end
