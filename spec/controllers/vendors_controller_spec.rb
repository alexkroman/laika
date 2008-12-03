require File.dirname(__FILE__) + '/../spec_helper'

shared_examples_for "vendor all users" do
  it "allows creation of new vendors" do
    count = Vendor.count
    post :create, :vendor => { :public_id => 'BARFOO'}
    Vendor.count.should == count + 1
  end
end

describe VendorsController do
  fixtures :users
  describe "in use by an admin" do
    before(:each) do
      @user = users(:alex_kroman)
      @user.roles << Role.administrator
      controller.stub!(:current_user).and_return(@user)
      @vendor = Vendor.create!(:public_id => 'SOMETHING', :user => nil)
    end

    it_should_behave_like "vendor all users"

    it "permits renaming of other users' vendors" do
      put :update, :id => @vendor.id, :vendor => { :public_id => 'GOODIDEA' }
      @vendor.reload
      @vendor.public_id.should == 'GOODIDEA'
    end

    it "permits deletion of other users' vendors" do
      put :update, :id => @vendor.id
      lambda { @vendor.reload }.should_not raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "in use by a non-admin" do
    before(:each) do
      @user = users(:alex_kroman)
      @user.roles.clear
      controller.stub!(:current_user).and_return(@user)
      @vendor = Vendor.create!(:public_id => 'SOMETHING', :user => nil)
    end

    it_should_behave_like "vendor all users"

    it "does not permit renaming of other users' vendors" do
      put :update, :id => @vendor.id, :vendor => { :public_id => 'BADIDEA' }
      @vendor.reload
      @vendor.public_id.should == 'SOMETHING'
    end

    it "does not permit deletion of other users' vendors" do
      put :update, :id => @vendor.id
      lambda { @vendor.reload }.should_not raise_error(ActiveRecord::RecordNotFound)
    end

  end
end
