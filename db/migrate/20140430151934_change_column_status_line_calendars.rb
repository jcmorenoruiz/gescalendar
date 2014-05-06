class ChangeColumnStatusLineCalendars < ActiveRecord::Migration
  def change
  		change_column :line_calendars, :status, :boolean, default: 't'
  end
end
