require 'spec_helper'

describe "/payment_methods/edit.html.erb" do
  include PaymentMethodsHelper

  before(:each) do
    assigns[:payment_method] = @payment_method = stub_model(PaymentMethod,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "renders the edit payment_method form" do
    render

    response.should have_tag("form[action=#{payment_method_path(@payment_method)}][method=post]") do
      with_tag('input#payment_method_name[name=?]', "payment_method[name]")
      with_tag('textarea#payment_method_description[name=?]', "payment_method[description]")
    end
  end
end
