require File.dirname(__FILE__) + '/../spec_helper'

describe TestPlanManagerController do
  fixtures :patient_data, :vendors, :users, :kinds

  describe "operated by a non-admin" do
    before do
      @current_user = users(:alex_kroman)
      @current_user.roles.clear
      controller.stub!(:current_user).and_return(@current_user)
    end

    it "should retain the previous vendor and kind selection" do
      patient_data = patient_data(:joe_smith)
      vendor = Vendor.find :first
      kind = Kind.find :first
      controller.send( :last_selected_kind_id=,   nil)
      controller.send( :last_selected_vendor_id=, nil)

      get :assign_patient_data, :pd_id => patient_data, :vendor_test_plan => { :vendor_id => vendor, :kind_id => kind }

      controller.send( :last_selected_vendor ).should == vendor
      controller.send( :last_selected_kind   ).should == kind
    end

    it "should auto-assign current user" do
      patient_data = patient_data(:joe_smith)
      vendor = Vendor.find :first
      kind = Kind.find :first

      User.should_not_receive(:find)

      get :assign_patient_data, :pd_id => patient_data, :vendor_test_plan => { :vendor_id => vendor, :kind_id => kind }
    end

    it "should not assign selected user" do
      other = users(:rob_dingwell)
      patient_data = patient_data(:joe_smith)
      vendor = Vendor.find :first
      kind = Kind.find :first

      User.should_not_receive(:find).with(other)

      get :assign_patient_data, :pd_id => patient_data, :vendor_test_plan => {:user_id => other, :vendor_id => vendor, :kind_id => kind }
    end
  end

  describe "operated by an admin" do
    before do
      @current_user = users(:alex_kroman)
      @current_user.roles.clear
      @current_user.roles << Role.administrator
      controller.stub!(:current_user).and_return(@current_user)
    end

    it "should assign selected user" do
      other = users(:rob_dingwell)
      patient_data = patient_data(:joe_smith)
      vendor = Vendor.find :first
      kind = Kind.find :first

      User.should_receive(:find).with(other)

      get :assign_patient_data, :pd_id => patient_data, :vendor_test_plan => {:user_id => other, :vendor_id => vendor, :kind_id => kind }
    end
  end
end
