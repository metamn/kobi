require 'spec_helper'

describe "/categories/edit.html.erb" do
  include CategoriesHelper

  before(:each) do
    assigns[:category] = @category = stub_model(Category,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "renders the edit category form" do
    render

    response.should have_tag("form[action=#{category_path(@category)}][method=post]") do
      with_tag('input#category_name[name=?]', "category[name]")
      with_tag('textarea#category_description[name=?]', "category[description]")
    end
  end
end
