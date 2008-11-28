require 'test_helper'

class LibrariesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:libraries)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_library
    assert_difference('Library.count') do
      post :create, :library => { }
    end

    assert_redirected_to library_path(assigns(:library))
  end

  def test_should_show_library
    get :show, :id => libraries(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => libraries(:one).id
    assert_response :success
  end

  def test_should_update_library
    put :update, :id => libraries(:one).id, :library => { }
    assert_redirected_to library_path(assigns(:library))
  end

  def test_should_destroy_library
    assert_difference('Library.count', -1) do
      delete :destroy, :id => libraries(:one).id
    end

    assert_redirected_to libraries_path
  end
end
