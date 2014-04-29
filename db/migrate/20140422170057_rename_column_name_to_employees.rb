class RenameColumnNameToEmployees < ActiveRecord::Migration
  def change
  	rename_column :employees, :name, :nombre
  end
end
