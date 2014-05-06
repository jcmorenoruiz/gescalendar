require 'test_helper'

class DefaultLineCalendarsControllerTest < ActionController::TestCase
  setup do
    @default_line_calendar = default_line_calendars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:default_line_calendars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create default_line_calendar" do
    assert_difference('DefaultLineCalendar.count') do
      post :create, default_line_calendar: { fecha: @default_line_calendar.fecha, nombre: @default_line_calendar.nombre, status: @default_line_calendar.status }
    end

    assert_redirected_to default_line_calendar_path(assigns(:default_line_calendar))
  end

  test "should show default_line_calendar" do
    get :show, id: @default_line_calendar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @default_line_calendar
    assert_response :success
  end

  test "should update default_line_calendar" do
    patch :update, id: @default_line_calendar, default_line_calendar: { fecha: @default_line_calendar.fecha, nombre: @default_line_calendar.nombre, status: @default_line_calendar.status }
    assert_redirected_to default_line_calendar_path(assigns(:default_line_calendar))
  end

  test "should destroy default_line_calendar" do
    assert_difference('DefaultLineCalendar.count', -1) do
      delete :destroy, id: @default_line_calendar
    end

    assert_redirected_to default_line_calendars_path
  end
end
