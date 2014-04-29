class ModifyColumnStatusEmployees < ActiveRecord::Migration
  def change
  	change_column :employees, :status, :boolean, default: 't'
  end
end
