class CreateDefaultRequestTypes < ActiveRecord::Migration
  def change
    create_table :default_request_types do |t|
      t.string :nombre
      t.integer :num_dias_max
      t.boolean :status

      t.timestamps
    end
  end
end
