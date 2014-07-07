class AddDefaultCalendarsDays < ActiveRecord::Migration
  def change
  		change_column :calendars, :d1 , :boolean, default: 't'
  	 	change_column :calendars, :d2 , :boolean, default: 't'
  	 	change_column :calendars, :d3 , :boolean, default: 't'
  	 	change_column :calendars, :d4 , :boolean, default: 't'
  	 	change_column :calendars, :d5 , :boolean, default: 't'
  	 	change_column :calendars, :d6 , :boolean, default: 't'
  	 	change_column :calendars, :d7 , :boolean, default: 't'
  end
end
