class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.integer :anio
      t.date :fecha_apertura
      t.date :fecha_cierre
      t.integer :enterprise_id
      t.boolean :status

      t.timestamps
    end
  end
end
