require 'spec_helper'

describe "/expenses/edit.html.erb" do
  include ExpensesHelper

  before(:each) do
    assigns[:expense] = @expense = stub_model(Expense,
      :new_record? => false,
      :amount => 9.99
    )
  end

  it "renders the edit expense form" do
    render

    response.should have_tag("form[action=#{expense_path(@expense)}][method=post]") do
      with_tag('input#expense_amount[name=?]', "expense[amount]")
    end
  end
end
