require File.dirname(__FILE__) + '/../test_helper'

class DocumentLocationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:document_locations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_document_location
    assert_difference('DocumentLocation.count') do
      post :create, :document_location => { }
    end

    assert_redirected_to document_location_path(assigns(:document_location))
  end

  def test_should_show_document_location
    get :show, :id => document_locations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => document_locations(:one).id
    assert_response :success
  end

  def test_should_update_document_location
    put :update, :id => document_locations(:one).id, :document_location => { }
    assert_redirected_to document_location_path(assigns(:document_location))
  end

  def test_should_destroy_document_location
    assert_difference('DocumentLocation.count', -1) do
      delete :destroy, :id => document_locations(:one).id
    end

    assert_redirected_to document_locations_path
  end
end
