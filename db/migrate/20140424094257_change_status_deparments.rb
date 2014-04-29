class ChangeStatusDeparments < ActiveRecord::Migration
  def change
  	change_column :departments, :status, :boolean, default: 't'
  end
end
