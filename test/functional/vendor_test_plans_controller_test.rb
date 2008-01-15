require File.dirname(__FILE__) + '/../test_helper'

class VendorTestPlansControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_test_plans)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_vendor_test_plan
    assert_difference('VendorTestPlan.count') do
      post :create, :vendor_test_plan => { }
    end

    assert_redirected_to vendor_test_plan_path(assigns(:vendor_test_plan))
  end

  def test_should_show_vendor_test_plan
    get :show, :id => vendor_test_plans(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => vendor_test_plans(:one).id
    assert_response :success
  end

  def test_should_update_vendor_test_plan
    put :update, :id => vendor_test_plans(:one).id, :vendor_test_plan => { }
    assert_redirected_to vendor_test_plan_path(assigns(:vendor_test_plan))
  end

  def test_should_destroy_vendor_test_plan
    assert_difference('VendorTestPlan.count', -1) do
      delete :destroy, :id => vendor_test_plans(:one).id
    end

    assert_redirected_to vendor_test_plans_path
  end
end
