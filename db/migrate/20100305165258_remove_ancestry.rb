class RemoveAncestry < ActiveRecord::Migration
  def self.up
    remove_column :categories, :ancestry_depth
  end

  def self.down
    add_column :categories, :ancestry_depth, :integer
  end
end
