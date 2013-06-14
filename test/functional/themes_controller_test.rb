require 'test_helper'

class ThemesControllerTest < ActionController::TestCase
  setup do
    @theme = themes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:themes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create theme" do
    assert_difference('Theme.count') do
      post :create, theme: { theme_desc: @theme.theme_desc, theme_title: @theme.theme_title }
    end

    assert_redirected_to theme_path(assigns(:theme))
  end

  test "should show theme" do
    get :show, id: @theme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @theme
    assert_response :success
  end

  test "should update theme" do
    put :update, id: @theme, theme: { theme_desc: @theme.theme_desc, theme_title: @theme.theme_title }
    assert_redirected_to theme_path(assigns(:theme))
  end

  test "should destroy theme" do
    assert_difference('Theme.count', -1) do
      delete :destroy, id: @theme
    end

    assert_redirected_to themes_path
  end
end
