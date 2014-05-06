class AddWeekDaysCalendars < ActiveRecord::Migration
  def change
  	 	add_column :calendars, :d1 , :boolean
  	 	add_column :calendars, :d2 , :boolean
  	 	add_column :calendars, :d3 , :boolean
  	 	add_column :calendars, :d4 , :boolean
  	 	add_column :calendars, :d5 , :boolean
  	 	add_column :calendars, :d6 , :boolean
  	 	add_column :calendars, :d7 , :boolean
  end
end
