json.array!(@default_line_calendars) do |default_line_calendar|
  json.extract! default_line_calendar, :id, :fecha, :nombre, :status
  json.url default_line_calendar_url(default_line_calendar, format: :json)
end
