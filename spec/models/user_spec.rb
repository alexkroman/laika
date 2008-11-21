require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  fixtures :users, :roles

  describe "with administrator role" do
    before(:each) do
      @user = users(:alex_kroman)
      @user.roles.clear
      @user.roles << Role.administrator
    end

    it "is an administrator" do
      @user.administrator?.should be_true
    end
  end

  describe "without administrator role" do
    before(:each) do
      @user = users(:alex_kroman)
      @user.roles.delete(Role.administrator)
    end

    it "is not an administrator" do
      @user.administrator?.should be_false
    end
  end
end
