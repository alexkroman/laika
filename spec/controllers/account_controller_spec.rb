require File.dirname(__FILE__) + '/../spec_helper'

describe AccountController do
  describe "before authentication" do
    it "should redirect index to login" do
      get :index
      response.should redirect_to('/account/login')
    end

    it "should return success on get login" do
      get :login
      response.should be_success
    end

    it "should redirect to login on failed login" do
      User.stub!(:authenticate).and_return nil
      post :login, { :email => 'foo@bar.com', :password => 'barfoo' }
      response.should redirect_to('/account/login')
    end

    it "should redirect to patient_data after successful login (no test plans)" do
      controller.stub!(:current_user).and_return mock_model(User, :vendor_test_plans => [])
      post :login, { :email => 'foo@bar.com', :password => 'barfoo' }
      response.should redirect_to(patient_data_url)
    end

    it "should redirect to vendor_test_plans after successful login (with test plans)" do
      controller.stub!(:current_user).and_return mock_model(User, :vendor_test_plans => [mock_model(VendorTestPlan)])
      post :login, { :email => 'foo@bar.com', :password => 'barfoo' }
      response.should redirect_to(vendor_test_plans_url)
    end

    it "should return success on get signup" do
      get :signup
      response.should be_success
    end

    it "should redirect to patient_data after successful signup" do
      post :signup, {
        :user => {
          :first_name => 'bar',
          :last_name => 'foo',
          :email => 'foo@bar.com',
          :password => 'barfoo',
          :password_confirmation => 'barfoo',
        }
      }
      response.should redirect_to(patient_data_url)
    end

    it "should re-render after unsuccessful signup" do
      post :signup, {
        :user => {
          :first_name => 'bar',
          :last_name => 'foo',
          :email => 'foo@bar.com',
          :password => 'barfoo',
          :password_confirmation => 'barfoobar',
        }
      }
      response.should render_template('account/signup')
    end

    it "should return success on get forgot_password" do
      get :forgot_password
      response.should be_success
    end

    it "should redirect to forgot_password on failed forgotten password lookups" do
      post :forgot_password, :email => 'foo@bar.com'
      response.should redirect_to('/account/forgot_password')
    end

    it "should redirect on invalid reset_password (id required)" do
      get :reset_password
      response.should redirect_to('/account/forgot_password')
    end

    it "should return success with a valid reset code on reset_password" do
      User.stub!(:find_by_password_reset_code).and_return mock_model(User)
      get :reset_password, :id => 'something'
      response.should be_success
      assigns[:notice].should be_nil
    end

    it "should display an error notice with mismatched passwords on reset_password" do
      User.stub!(:find_by_password_reset_code).and_return mock_model(User)
      get :reset_password, :id => 'something', :password => 'foo', :password_confirmation => 'bar'
      response.should be_success
      assigns[:notice].should_not be_nil
    end

    it "should display an error notice with invalid passwords on reset_password" do
      # TODO should stub_model, need rspec 1.1.4
      User.stub!(:find_by_password_reset_code).and_return mock_model(User, :save => false,
        :password= => nil, :password_confirmation= => nil, :reset_password => nil)
      get :reset_password, :id => 'something', :password => 'f', :password_confirmation => 'f'
      response.should be_success
      assigns[:notice].should_not be_nil
    end

    it "should redirect to login on a successful password reset" do
      # TODO should stub_model, need rspec 1.1.4
      User.stub!(:find_by_password_reset_code).and_return mock_model(User, :save => true,
        :password= => nil, :password_confirmation= => nil, :reset_password => nil)
      get :reset_password, :id => 'something', :password => 'foo', :password_confirmation => 'foo'
      response.should redirect_to('/account/login')
    end

  end

  describe "after authentication" do
    before(:each) do
      @user = mock_model(User)
      controller.stub!(:current_user).and_return(@user)
    end

    it "should load the index" do
      get :index
      response.should be_success
    end
  end

end

