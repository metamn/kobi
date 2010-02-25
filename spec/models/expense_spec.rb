require 'spec_helper'

describe Expense do
  before(:each) do
    @valid_attributes = {
      :date => Time.now,
      :amount => 9.99
    }
  end

  it "should create a new instance given valid attributes" do
    Expense.create!(@valid_attributes)
  end
end
