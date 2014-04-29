class ChangeStatusDeparments < ActiveRecord::Migration
  def change
  	change_column :departments, :status, :boolean, default: 1
  end
end
