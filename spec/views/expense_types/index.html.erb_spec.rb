require 'spec_helper'

describe "/expense_types/index.html.erb" do
  include ExpenseTypesHelper

  before(:each) do
    assigns[:expense_types] = [
      stub_model(ExpenseType,
        :name => "value for name",
        :description => "value for description"
      ),
      stub_model(ExpenseType,
        :name => "value for name",
        :description => "value for description"
      )
    ]
  end

  it "renders a list of expense_types" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
  end
end
