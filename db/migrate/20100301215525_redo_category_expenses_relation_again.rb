class RedoCategoryExpensesRelationAgain < ActiveRecord::Migration
  def self.up
    add_column :expenses, :category_id, :integer
    remove_column :categories, :expense_id
  end

  def self.down
    remove_column :expenses, :category_id
    add_column :categories, :expense_id, :integer
  end
end
