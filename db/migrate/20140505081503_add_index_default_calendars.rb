class AddIndexDefaultCalendars < ActiveRecord::Migration
  def change
  		add_index :default_calendars, :anio, unique: true
  		add_index :default_line_calendars,[:fecha,:default_calendar_id], unique: true
  end
end
