class AddTagsToExpenses2 < ActiveRecord::Migration
  def self.up
    remove_column :users, :tags_saved
    remove_column :users, :category_saved  
    
    add_column :expenses, :tags_saved, :string
    add_column :expenses, :category_saved, :string
  end

  def self.down
    remove_column :expenses, :tags_saved
    remove_column :expenses, :category_saved  
  end
end
