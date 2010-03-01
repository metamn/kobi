require 'spec_helper'

describe "/categories/new.html.erb" do
  include CategoriesHelper

  before(:each) do
    assigns[:category] = stub_model(Category,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "renders new category form" do
    render

    response.should have_tag("form[action=?][method=post]", categories_path) do
      with_tag("input#category_name[name=?]", "category[name]")
      with_tag("textarea#category_description[name=?]", "category[description]")
    end
  end
end
