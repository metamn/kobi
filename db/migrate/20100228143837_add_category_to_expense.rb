class AddCategoryToExpense < ActiveRecord::Migration
  def self.up
    add_column :categories, :expense_id, :integer
  end

  def self.down
    remove_column :categories, :expense_id, :integer
  end
end
