class AddIndexCalendars < ActiveRecord::Migration
  def change
  		add_index :calendars, [:anio,:enterprise_id], unique: true
  end
end
