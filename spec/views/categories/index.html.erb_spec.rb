require 'spec_helper'

describe "/categories/index.html.erb" do
  include CategoriesHelper

  before(:each) do
    assigns[:categories] = [
      stub_model(Category,
        :name => "value for name",
        :description => "value for description"
      ),
      stub_model(Category,
        :name => "value for name",
        :description => "value for description"
      )
    ]
  end

  it "renders a list of categories" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
  end
end
