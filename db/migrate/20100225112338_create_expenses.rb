class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.datetime :date
      t.decimal :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
