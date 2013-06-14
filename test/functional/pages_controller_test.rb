require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  setup do
    @page = pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      post :create, page: { org_id: @page.org_id, pag_body_text: @page.pag_body_text, pag_location: @page.pag_location, pag_menu: @page.pag_menu, pag_menu_position: @page.pag_menu_position, pag_public: @page.pag_public, pag_slug: @page.pag_slug, pag_target_url: @page.pag_target_url, pag_title: @page.pag_title }
    end

    assert_redirected_to page_path(assigns(:page))
  end

  test "should show page" do
    get :show, id: @page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page
    assert_response :success
  end

  test "should update page" do
    put :update, id: @page, page: { org_id: @page.org_id, pag_body_text: @page.pag_body_text, pag_location: @page.pag_location, pag_menu: @page.pag_menu, pag_menu_position: @page.pag_menu_position, pag_public: @page.pag_public, pag_slug: @page.pag_slug, pag_target_url: @page.pag_target_url, pag_title: @page.pag_title }
    assert_redirected_to page_path(assigns(:page))
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete :destroy, id: @page
    end

    assert_redirected_to pages_path
  end
end
