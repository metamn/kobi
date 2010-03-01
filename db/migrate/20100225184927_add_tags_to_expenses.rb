class AddTagsToExpenses < ActiveRecord::Migration
  def self.up
    add_column :users, :tags_saved, :string
    add_column :users, :category_saved, :string
  end

  def self.down
    remove_column :users, :tags_saved
    remove_column :users, :category_saved    
  end
end
