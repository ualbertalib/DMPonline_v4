require 'test_helper'

class OrganisationsControllerTest < ActionController::TestCase
  setup do
    @organisation = organisations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organisations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organisation" do
    assert_difference('Organisation.count') do
      post :create, organisation: { org_abbre: @organisation.org_abbre, org_banner_file_id: @organisation.org_banner_file_id, org_desc: @organisation.org_desc, org_domain: @organisation.org_domain, org_logo_file_id: @organisation.org_logo_file_id, org_name: @organisation.org_name, org_stylesheet_file_id: @organisation.org_stylesheet_file_id, org_target_url: @organisation.org_target_url, org_type_id: @organisation.org_type_id, org_wayfless_entite: @organisation.org_wayfless_entite }
    end

    assert_redirected_to organisation_path(assigns(:organisation))
  end

  test "should show organisation" do
    get :show, id: @organisation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organisation
    assert_response :success
  end

  test "should update organisation" do
    put :update, id: @organisation, organisation: { org_abbre: @organisation.org_abbre, org_banner_file_id: @organisation.org_banner_file_id, org_desc: @organisation.org_desc, org_domain: @organisation.org_domain, org_logo_file_id: @organisation.org_logo_file_id, org_name: @organisation.org_name, org_stylesheet_file_id: @organisation.org_stylesheet_file_id, org_target_url: @organisation.org_target_url, org_type_id: @organisation.org_type_id, org_wayfless_entite: @organisation.org_wayfless_entite }
    assert_redirected_to organisation_path(assigns(:organisation))
  end

  test "should destroy organisation" do
    assert_difference('Organisation.count', -1) do
      delete :destroy, id: @organisation
    end

    assert_redirected_to organisations_path
  end
end
