class RedoCategoryExpensesRelation < ActiveRecord::Migration
  def self.up
    remove_column :expenses, :category_id
    add_column :categories, :expense_id, :integer
  end

  def self.down
    add_column :expenses, :category_id, :integer
    remove_column :categories, :expense_id
  end
end
