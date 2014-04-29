class ChangeColumnStatusEnterprises < ActiveRecord::Migration
  def change
  	change_column :enterprises, :status, :boolean, default: 1
  	change_column :enterprises, :notif_solicitudes, :boolean, default: 1
  	change_column :enterprises, :notif_auditoria, :boolean, default: 1
  	change_column :enterprises, :notif_apertura, :boolean, default: 1
  end
end
