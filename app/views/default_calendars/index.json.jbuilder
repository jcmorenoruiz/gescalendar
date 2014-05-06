json.array!(@default_calendars) do |default_calendar|
  json.extract! default_calendar, :id, :anio, :status
  json.url default_calendar_url(default_calendar, format: :json)
end
