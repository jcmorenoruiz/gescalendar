require 'test_helper'

class DefaultRequestTypesControllerTest < ActionController::TestCase
  setup do
    @default_request_type = default_request_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:default_request_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create default_request_type" do
    assert_difference('DefaultRequestType.count') do
      post :create, default_request_type: { nombre: @default_request_type.nombre, num_dias_max: @default_request_type.num_dias_max, status: @default_request_type.status }
    end

    assert_redirected_to default_request_type_path(assigns(:default_request_type))
  end

  test "should show default_request_type" do
    get :show, id: @default_request_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @default_request_type
    assert_response :success
  end

  test "should update default_request_type" do
    patch :update, id: @default_request_type, default_request_type: { nombre: @default_request_type.nombre, num_dias_max: @default_request_type.num_dias_max, status: @default_request_type.status }
    assert_redirected_to default_request_type_path(assigns(:default_request_type))
  end

  test "should destroy default_request_type" do
    assert_difference('DefaultRequestType.count', -1) do
      delete :destroy, id: @default_request_type
    end

    assert_redirected_to default_request_types_path
  end
end
