require 'test_helper'

class LineCalendarsControllerTest < ActionController::TestCase
  setup do
    @line_calendar = line_calendars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_calendars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_calendar" do
    assert_difference('LineCalendar.count') do
      post :create, line_calendar: { calendar_id: @line_calendar.calendar_id, desc: @line_calendar.desc, dia: @line_calendar.dia, fecha: @line_calendar.fecha, status: @line_calendar.status }
    end

    assert_redirected_to line_calendar_path(assigns(:line_calendar))
  end

  test "should show line_calendar" do
    get :show, id: @line_calendar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_calendar
    assert_response :success
  end

  test "should update line_calendar" do
    patch :update, id: @line_calendar, line_calendar: { calendar_id: @line_calendar.calendar_id, desc: @line_calendar.desc, dia: @line_calendar.dia, fecha: @line_calendar.fecha, status: @line_calendar.status }
    assert_redirected_to line_calendar_path(assigns(:line_calendar))
  end

  test "should destroy line_calendar" do
    assert_difference('LineCalendar.count', -1) do
      delete :destroy, id: @line_calendar
    end

    assert_redirected_to line_calendars_path
  end
end
