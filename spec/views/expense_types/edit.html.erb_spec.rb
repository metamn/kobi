require 'spec_helper'

describe "/expense_types/edit.html.erb" do
  include ExpenseTypesHelper

  before(:each) do
    assigns[:expense_type] = @expense_type = stub_model(ExpenseType,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "renders the edit expense_type form" do
    render

    response.should have_tag("form[action=#{expense_type_path(@expense_type)}][method=post]") do
      with_tag('input#expense_type_name[name=?]', "expense_type[name]")
      with_tag('textarea#expense_type_description[name=?]', "expense_type[description]")
    end
  end
end
