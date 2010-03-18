require 'spec_helper'

describe ExpenseTypesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/expense_types" }.should route_to(:controller => "expense_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/expense_types/new" }.should route_to(:controller => "expense_types", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/expense_types/1" }.should route_to(:controller => "expense_types", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/expense_types/1/edit" }.should route_to(:controller => "expense_types", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/expense_types" }.should route_to(:controller => "expense_types", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/expense_types/1" }.should route_to(:controller => "expense_types", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/expense_types/1" }.should route_to(:controller => "expense_types", :action => "destroy", :id => "1") 
    end
  end
end
