class AddIndexDefaultLineCalendars < ActiveRecord::Migration
  def change
  		add_column :default_line_calendars, :default_calendar_id , :integer
  end
end
