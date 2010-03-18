require 'spec_helper'

describe "/expense_types/show.html.erb" do
  include ExpenseTypesHelper
  before(:each) do
    assigns[:expense_type] = @expense_type = stub_model(ExpenseType,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
  end
end
