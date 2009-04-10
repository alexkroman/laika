require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  describe "in use by an admin" do
    before do
      @admin = stub_model(User, :administrator? => true)
      controller.stub!(:current_user).and_return(@admin)
    end

    it "should permit deletion of other users" do
      @user = stub_model(User, :display_name => '')
      @user.should_receive(:destroy)
      User.stub!(:find).and_return(@user)
      delete :destroy, :id => '1'
    end

    it "should not permit deletion of self" do
      @admin.should_not_receive(:destroy)
      User.stub!(:find).and_return(@admin)
      delete :destroy, :id => '1'
    end
  end

  describe "in use by a non-admin" do
    before do
      @operator = stub_model(User, :administrator? => false)
      controller.stub!(:current_user).and_return(@operator)
    end

    it "should not permit deletion of other users" do
      @user = stub_model(User, :display_name => '')
      @user.should_not_receive(:destroy)
      User.stub!(:find).and_return(@user)
      delete :destroy, :id => '1'
    end

    it "should not permit deletion of self" do
      @operator.should_not_receive(:destroy)
      User.stub!(:find).and_return(@operator)
      delete :destroy, :id => '1'
    end
  end

  describe "handling GET /users" do

    before(:each) do
      @user = mock_model(User, :administrator? => false, :vendors => [])
      @users = [@user]
      @vendor = mock_model(Vendor)
      @vendors = [@vendor]
      User.stub!(:find).and_return(@user)
      User.stub!(:find).with(:all).and_return(@users)
      Vendor.stub!(:unclaimed).and_return(@vendors)
      controller.stub!(:current_user).and_return(@user)
    end
  
    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should render index template" do
      get :index
      response.should render_template('index')
    end
  
    it "should find all users" do
      User.should_receive(:find).with(:all).and_return(@users)
      get :index
    end
  
    it "should find user-specific vendors" do
      @user.should_receive(:vendors).and_return(@vendors)
      get :index
    end

    it "should assign the found users for the view" do
      get :index
      assigns[:users].should == @users
    end
  end

  describe "handling GET /users/1/edit" do

    before(:each) do
      @user = mock_model(User, :administrator? => false, :display_name => 'Alf', :vendors => [])
      User.stub!(:find).and_return(@user)
      controller.stub!(:current_user).and_return(@user)
    end
  
    it "should be successful" do
      get :edit, :id => "1"
      response.should be_success
    end
  
    it "should render edit template" do
      get :edit, :id => "1"
      response.should render_template('edit')
    end
  
    it "should assign the found User for the view" do
      get :edit, :id => "1"
      assigns[:user].should equal(@user)
    end
  end

  describe "handling PUT /users/1" do

    before(:each) do
      @user = mock_model(User, :to_param => "1", :administrator? => false, :vendors => [], :update_attributes => true)
      User.stub!(:find).and_return(@user)
      controller.stub!(:current_user).and_return(@user)
    end
    
    describe "with successful update" do

      it "should update the found user" do
        put :update, :id => "1", :user => {:first_name => 'Alex'}
        assigns(:user).should equal(@user)
      end

      it "should assign the found user for the view" do
        put :update, :id => "1", :user => {:first_name => 'Alex'}
        assigns(:user).should equal(@user)
      end

      it "should redirect to the user" do
        put :update, :id => "1", :user => {:first_name => 'Alex'}
        response.should redirect_to(edit_user_url("1"))
      end

    end

    describe "with changing the password" do
        
      it "should update the user" do
        put :update, :id => "1", :user => {:password => '123456', :password_confirmation => '123456'}
        assigns(:user).should equal(@user)
      end

    end
    
    describe "with failed update" do

      it "should re-render 'edit'" do
        @user.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

end
