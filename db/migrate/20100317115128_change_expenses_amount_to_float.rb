class ChangeExpensesAmountToFloat < ActiveRecord::Migration
  def self.up
    change_column :expenses, :amount, :float    
  end

  def self.down
    change_column :expenses, :amount, :decimal
  end
end
