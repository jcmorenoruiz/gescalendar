class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.date :desde
      t.date :hasta
      t.integer :num_min_emp
      t.boolean :status
      t.string :cargo
      t.integer :department_id

      t.timestamps
    end
  end
end
