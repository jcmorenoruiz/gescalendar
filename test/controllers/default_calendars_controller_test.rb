require 'test_helper'

class DefaultCalendarsControllerTest < ActionController::TestCase
  setup do
    @default_calendar = default_calendars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:default_calendars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create default_calendar" do
    assert_difference('DefaultCalendar.count') do
      post :create, default_calendar: { anio: @default_calendar.anio, status: @default_calendar.status }
    end

    assert_redirected_to default_calendar_path(assigns(:default_calendar))
  end

  test "should show default_calendar" do
    get :show, id: @default_calendar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @default_calendar
    assert_response :success
  end

  test "should update default_calendar" do
    patch :update, id: @default_calendar, default_calendar: { anio: @default_calendar.anio, status: @default_calendar.status }
    assert_redirected_to default_calendar_path(assigns(:default_calendar))
  end

  test "should destroy default_calendar" do
    assert_difference('DefaultCalendar.count', -1) do
      delete :destroy, id: @default_calendar
    end

    assert_redirected_to default_calendars_path
  end
end
