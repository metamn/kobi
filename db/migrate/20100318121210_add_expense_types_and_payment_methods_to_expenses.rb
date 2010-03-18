class AddExpenseTypesAndPaymentMethodsToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :expense_type_id, :integer
    add_column :expenses, :payment_method_id, :integer
  end

  def self.down
    remove_column :expenses, :expense_type_id
    remove_column :expenses, :payment_method_id
  end
end
