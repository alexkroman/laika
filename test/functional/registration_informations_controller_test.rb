require File.dirname(__FILE__) + '/../test_helper'

class RegistrationInformationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:registration_informations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_registration_information
    assert_difference('RegistrationInformation.count') do
      post :create, :registration_information => { }
    end

    assert_redirected_to registration_information_path(assigns(:registration_information))
  end

  def test_should_show_registration_information
    get :show, :id => registration_informations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => registration_informations(:one).id
    assert_response :success
  end

  def test_should_update_registration_information
    put :update, :id => registration_informations(:one).id, :registration_information => { }
    assert_redirected_to registration_information_path(assigns(:registration_information))
  end

  def test_should_destroy_registration_information
    assert_difference('RegistrationInformation.count', -1) do
      delete :destroy, :id => registration_informations(:one).id
    end

    assert_redirected_to registration_informations_path
  end
end
