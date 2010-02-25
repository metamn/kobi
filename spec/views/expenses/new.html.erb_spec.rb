require 'spec_helper'

describe "/expenses/new.html.erb" do
  include ExpensesHelper

  before(:each) do
    assigns[:expense] = stub_model(Expense,
      :new_record? => true,
      :amount => 9.99
    )
  end

  it "renders new expense form" do
    render

    response.should have_tag("form[action=?][method=post]", expenses_path) do
      with_tag("input#expense_amount[name=?]", "expense[amount]")
    end
  end
end
