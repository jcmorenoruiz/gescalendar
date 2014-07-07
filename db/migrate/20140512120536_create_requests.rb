class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :motivo
      t.string :motivo_rev
      t.date :desde
      t.date :hasta
      t.integer :status
      t.integer :request_type_id, :limit => 4
      t.integer :employee_id, :limit => 4

      t.timestamps
    end
  end
end
