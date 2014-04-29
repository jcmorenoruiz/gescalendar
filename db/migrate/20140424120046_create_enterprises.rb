class CreateEnterprises < ActiveRecord::Migration
  def change
    create_table :enterprises do |t|
      t.string :nombre
      t.boolean :notif_solicitudes
      t.boolean :notif_auditoria
      t.boolean :notif_apertura
      t.date :fecha_baja
      t.boolean :status

      t.timestamps
    end
  end
end
