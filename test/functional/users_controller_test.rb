require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { user_email: @user.user_email, user_firstname: @user.user_firstname, user_last_login: @user.user_last_login, user_login_count: @user.user_login_count, user_orcid_id: @user.user_orcid_id, user_password: @user.user_password, user_shibboleth_id: @user.user_shibboleth_id, user_status_id: @user.user_status_id, user_surname: @user.user_surname, user_type_id: @user.user_type_id }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { user_email: @user.user_email, user_firstname: @user.user_firstname, user_last_login: @user.user_last_login, user_login_count: @user.user_login_count, user_orcid_id: @user.user_orcid_id, user_password: @user.user_password, user_shibboleth_id: @user.user_shibboleth_id, user_status_id: @user.user_status_id, user_surname: @user.user_surname, user_type_id: @user.user_type_id }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
