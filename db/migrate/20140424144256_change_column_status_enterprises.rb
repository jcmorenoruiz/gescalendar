class ChangeColumnStatusEnterprises < ActiveRecord::Migration
  def change
  	change_column :enterprises, :status, :boolean, default: 't'
  	change_column :enterprises, :notif_solicitudes, :boolean, default: 't'
  	change_column :enterprises, :notif_auditoria, :boolean, default: 't'
  	change_column :enterprises, :notif_apertura, :boolean, default: 't'
  end
end
