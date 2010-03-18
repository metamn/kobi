require 'spec_helper'

describe ExpenseTypesController do

  def mock_expense_type(stubs={})
    @mock_expense_type ||= mock_model(ExpenseType, stubs)
  end

  describe "GET index" do
    it "assigns all expense_types as @expense_types" do
      ExpenseType.stub(:find).with(:all).and_return([mock_expense_type])
      get :index
      assigns[:expense_types].should == [mock_expense_type]
    end
  end

  describe "GET show" do
    it "assigns the requested expense_type as @expense_type" do
      ExpenseType.stub(:find).with("37").and_return(mock_expense_type)
      get :show, :id => "37"
      assigns[:expense_type].should equal(mock_expense_type)
    end
  end

  describe "GET new" do
    it "assigns a new expense_type as @expense_type" do
      ExpenseType.stub(:new).and_return(mock_expense_type)
      get :new
      assigns[:expense_type].should equal(mock_expense_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested expense_type as @expense_type" do
      ExpenseType.stub(:find).with("37").and_return(mock_expense_type)
      get :edit, :id => "37"
      assigns[:expense_type].should equal(mock_expense_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created expense_type as @expense_type" do
        ExpenseType.stub(:new).with({'these' => 'params'}).and_return(mock_expense_type(:save => true))
        post :create, :expense_type => {:these => 'params'}
        assigns[:expense_type].should equal(mock_expense_type)
      end

      it "redirects to the created expense_type" do
        ExpenseType.stub(:new).and_return(mock_expense_type(:save => true))
        post :create, :expense_type => {}
        response.should redirect_to(expense_type_url(mock_expense_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved expense_type as @expense_type" do
        ExpenseType.stub(:new).with({'these' => 'params'}).and_return(mock_expense_type(:save => false))
        post :create, :expense_type => {:these => 'params'}
        assigns[:expense_type].should equal(mock_expense_type)
      end

      it "re-renders the 'new' template" do
        ExpenseType.stub(:new).and_return(mock_expense_type(:save => false))
        post :create, :expense_type => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested expense_type" do
        ExpenseType.should_receive(:find).with("37").and_return(mock_expense_type)
        mock_expense_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :expense_type => {:these => 'params'}
      end

      it "assigns the requested expense_type as @expense_type" do
        ExpenseType.stub(:find).and_return(mock_expense_type(:update_attributes => true))
        put :update, :id => "1"
        assigns[:expense_type].should equal(mock_expense_type)
      end

      it "redirects to the expense_type" do
        ExpenseType.stub(:find).and_return(mock_expense_type(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(expense_type_url(mock_expense_type))
      end
    end

    describe "with invalid params" do
      it "updates the requested expense_type" do
        ExpenseType.should_receive(:find).with("37").and_return(mock_expense_type)
        mock_expense_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :expense_type => {:these => 'params'}
      end

      it "assigns the expense_type as @expense_type" do
        ExpenseType.stub(:find).and_return(mock_expense_type(:update_attributes => false))
        put :update, :id => "1"
        assigns[:expense_type].should equal(mock_expense_type)
      end

      it "re-renders the 'edit' template" do
        ExpenseType.stub(:find).and_return(mock_expense_type(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested expense_type" do
      ExpenseType.should_receive(:find).with("37").and_return(mock_expense_type)
      mock_expense_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the expense_types list" do
      ExpenseType.stub(:find).and_return(mock_expense_type(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(expense_types_url)
    end
  end

end
