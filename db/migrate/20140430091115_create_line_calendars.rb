class CreateLineCalendars < ActiveRecord::Migration
  def change
    create_table :line_calendars do |t|
      t.date :fecha
      t.string :dia
      t.string :desc
      t.integer :calendar_id
      t.boolean :status

      t.timestamps
    end
  end
end
