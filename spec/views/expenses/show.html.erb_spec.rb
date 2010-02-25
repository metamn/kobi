require 'spec_helper'

describe "/expenses/show.html.erb" do
  include ExpensesHelper
  before(:each) do
    assigns[:expense] = @expense = stub_model(Expense,
      :amount => 9.99
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/9\.99/)
  end
end
