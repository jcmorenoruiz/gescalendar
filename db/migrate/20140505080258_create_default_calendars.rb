class CreateDefaultCalendars < ActiveRecord::Migration
  def change
    create_table :default_calendars do |t|
      t.integer :anio
      t.boolean :status

      t.timestamps
    end
  end
end
