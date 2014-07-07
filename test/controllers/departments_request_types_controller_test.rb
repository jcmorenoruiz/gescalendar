require 'test_helper'

class DepartmentsRequestTypesControllerTest < ActionController::TestCase
  setup do
    @departments_request_type = departments_request_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:departments_request_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create departments_request_type" do
    assert_difference('DepartmentsRequestType.count') do
      post :create, departments_request_type: { department_id: @departments_request_type.department_id, num_max_dias: @departments_request_type.num_max_dias, request_type_id: @departments_request_type.request_type_id }
    end

    assert_redirected_to departments_request_type_path(assigns(:departments_request_type))
  end

  test "should show departments_request_type" do
    get :show, id: @departments_request_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @departments_request_type
    assert_response :success
  end

  test "should update departments_request_type" do
    patch :update, id: @departments_request_type, departments_request_type: { department_id: @departments_request_type.department_id, num_max_dias: @departments_request_type.num_max_dias, request_type_id: @departments_request_type.request_type_id }
    assert_redirected_to departments_request_type_path(assigns(:departments_request_type))
  end

  test "should destroy departments_request_type" do
    assert_difference('DepartmentsRequestType.count', -1) do
      delete :destroy, id: @departments_request_type
    end

    assert_redirected_to departments_request_types_path
  end
end
