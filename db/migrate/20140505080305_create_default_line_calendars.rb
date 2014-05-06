class CreateDefaultLineCalendars < ActiveRecord::Migration
  def change
    create_table :default_line_calendars do |t|
      t.date :fecha
      t.string :nombre
      t.boolean :status

      t.timestamps
    end
  end
end
