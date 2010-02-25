class ModifyExpenses < ActiveRecord::Migration
  def self.up
    remove_column :expenses, :date
    add_column :expenses, :date, :date
  end

  def self.down
    remove_column :expenses, :date
  end
end
