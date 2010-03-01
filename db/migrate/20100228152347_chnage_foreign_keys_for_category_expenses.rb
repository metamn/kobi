class ChnageForeignKeysForCategoryExpenses < ActiveRecord::Migration
  def self.up
    remove_column :categories, :expense_id
    add_column :expenses, :category_id, :integer 
  end

  def self.down
    remove_column :expenses, :category_id
  end
end
