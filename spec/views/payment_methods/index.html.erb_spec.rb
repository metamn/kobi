require 'spec_helper'

describe "/payment_methods/index.html.erb" do
  include PaymentMethodsHelper

  before(:each) do
    assigns[:payment_methods] = [
      stub_model(PaymentMethod,
        :name => "value for name",
        :description => "value for description"
      ),
      stub_model(PaymentMethod,
        :name => "value for name",
        :description => "value for description"
      )
    ]
  end

  it "renders a list of payment_methods" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
  end
end
