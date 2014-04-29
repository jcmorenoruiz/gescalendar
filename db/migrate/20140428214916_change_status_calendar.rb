class ChangeStatusCalendar < ActiveRecord::Migration
  def change
  	change_column :calendars, :status, :boolean, default: 't'
  end
end
