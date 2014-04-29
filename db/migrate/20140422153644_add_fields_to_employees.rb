class AddFieldsToEmployees < ActiveRecord::Migration
  def change
  	add_column :employees, :fecha_alta , :date
  	add_column :employees, :fecha_baja , :date
  	add_column :employees, :status, :boolean
  	add_column :employees, :cargo, :string
  end
end
