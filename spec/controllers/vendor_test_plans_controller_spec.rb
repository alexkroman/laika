require File.dirname(__FILE__) + '/../spec_helper'

describe VendorTestPlansController do

  before(:each) do
    @user = stub :user
    controller.stub!(:current_user).and_return(@user)
  end

  describe "without test plans" do
    before(:each) { @user.stub!(:vendor_test_plans).and_return([]) }

    it "should setup display of the dashboard" do
      get :index
      response.should be_success
    end
  end

  describe "with test plans" do
    before(:each) do
      @vendor1 = stub :vendor1
      @vendor2 = stub :vendor2
      @vtp1 = stub :plan, :vendor => @vendor1, :validated? => false
      @vtp2 = stub :plan, :vendor => @vendor2, :validated? => true, :count_errors_and_warnings => [1,2]
      @user.stub!(:vendor_test_plans).and_return([ @vtp1, @vtp2 ])
    end

    it "should setup display of the dashboard" do
      get :index
      assigns[:vendors].to_set.should == [@vendor1, @vendor2].to_set
      assigns[:errors][@vtp1].should be_nil
      assigns[:warnings][@vtp1].should be_nil
      assigns[:errors][@vtp2].should == 1
      assigns[:warnings][@vtp2].should == 2
      response.should be_success
    end
  end
end
