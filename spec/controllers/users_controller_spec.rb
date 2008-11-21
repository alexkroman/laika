require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  describe "handling GET /users" do

    before(:each) do
      @user = mock_model(User, :administrator? => false)
      @users = [@user]
      @vendor = mock_model(Vendor)
      @vendors = [@vendor]
      User.stub!(:find).and_return(@user)
      User.stub!(:find).with(:all).and_return(@users)
      Vendor.stub!(:find).with(:all).and_return(@vendors)
      controller.stub!(:current_user).and_return(@user)
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all users" do
      User.should_receive(:find).with(:all).and_return(@users)
      do_get
    end
  
    it "should find all vendors" do
      Vendor.should_receive(:find).with(:all).and_return(@vendors)
      do_get
    end

    it "should assign the found users for the view" do
      do_get
      assigns[:users].should == @users
    end
  end

  describe "handling GET /users/1/edit" do

    before(:each) do
      @user = mock_model(User, :administrator? => false, :display_name => 'Alf')
      User.stub!(:find).and_return(@user)
      controller.stub!(:current_user).and_return(@user)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should assign the found User for the view" do
      do_get
      assigns[:user].should equal(@user)
    end
  end

  describe "handling PUT /users/1" do

    before(:each) do
      @user = mock_model(User, :to_param => "1", :administrator? => false)
      User.stub!(:find).and_return(@user)
      controller.stub!(:current_user).and_return(@user)
    end
    
    describe "with successful update" do

      def do_put
        @user.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1", :user => {:first_name => 'Alex'}
      end

      it "should update the found user" do
        do_put
        assigns(:user).should equal(@user)
      end

      it "should assign the found user for the view" do
        do_put
        assigns(:user).should equal(@user)
      end

      it "should redirect to the user" do
        do_put
        response.should redirect_to(edit_user_url("1"))
      end

    end

    describe "with changing the password" do
        
      def do_put
        @user.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1", :user => {:password => '123456', :password_confirmation => '123456'}
      end

      it "should update the user" do
        do_put
        assigns(:user).should equal(@user)
      end

    end
    
    describe "with failed update" do

      def do_put
        @user.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end

  end

end
