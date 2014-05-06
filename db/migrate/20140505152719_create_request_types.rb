class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.string :nombre
      t.integer :num_dias_max
      t.boolean :status
      t.integer :calendar_id

      t.timestamps
    end
  end
end
