require 'spec_helper'

describe "/expenses/index.html.erb" do
  include ExpensesHelper

  before(:each) do
    assigns[:expenses] = [
      stub_model(Expense,
        :amount => 9.99
      ),
      stub_model(Expense,
        :amount => 9.99
      )
    ]
  end

  it "renders a list of expenses" do
    render
    response.should have_tag("tr>td", 9.99.to_s, 2)
  end
end
