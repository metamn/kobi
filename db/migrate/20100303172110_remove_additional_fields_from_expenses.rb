class RemoveAdditionalFieldsFromExpenses < ActiveRecord::Migration
  def self.up
    remove_column :expenses, :tags_saved
    remove_column :expenses, :category_saved
  end

  def self.down
    add_column :expenses, :tags_saved, :string
    add_column :expenses, :category_saved, :string
  end
end
