require File.dirname(__FILE__) + '/../spec_helper'
require 'sort_order'

class SortOrderTestController < ActionController::Base
  include SortOrder
  def foo
    render :text => 'hi foo'
  end
  def bar
    render :text => 'hi bar'
  end
end

describe SortOrderTestController do
  before(:each) do
    @controller = SortOrderTestController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  it "should not respond to sort_order as an action" do
    lambda { get :sort_order }.should raise_error(ActionController::UnknownAction)
  end

  it "should not respond to sort_spec as an action" do
    lambda { get :sort_spec }.should raise_error(ActionController::UnknownAction)
  end

  it "should have nil sort order if no sort is given" do
    get :foo
    @controller.sort_order.should be_nil
  end

  it "should have nil sort order if a malformed sort is given" do
    get :foo, :sort => ';delete from important_table'
    @controller.sort_order.should be_nil

    get :foo, :sort => '--comment'
    @controller.sort_order.should be_nil

    get :foo, :sort => '/*comment*/'
    @controller.sort_order.should be_nil
  end

  it "should correctly set the sort order given a sort key" do
    get :foo, :sort => 'updated_at'
    @controller.sort_order.should == 'updated_at ASC'

    get :foo, :sort => '^updated_at'
    @controller.sort_order.should == 'updated_at DESC'
  end

  it "should reuse the sort order in subsequent calls to the same action" do
    get :foo
    @controller.sort_order.should be_nil

    get :foo, :sort => '^updated_at'
    @controller.sort_order.should == 'updated_at DESC'

    get :foo
    @controller.sort_order.should == 'updated_at DESC'
  end

  it "should not reuse the sort order in subsequent calls to different actions" do
    get :foo, :sort => 'updated_at'
    @controller.sort_order.should == 'updated_at ASC'

    get :bar
    @controller.sort_order.should be_nil
  end

  describe "with valid_sort_fields specified" do

    before(:all) { SortOrderTestController.valid_sort_fields = %w[updated_at] }
    after(:all)  { SortOrderTestController.valid_sort_fields = nil }

    it "should respect valid sort specs" do
      get :foo, :sort => 'updated_at'
      @controller.sort_order.should == 'updated_at ASC'
    end

    it "should not respect invalid sort specs" do
      get :foo, :sort => 'created_at'
      @controller.sort_order.should be_nil
    end
  end
end
