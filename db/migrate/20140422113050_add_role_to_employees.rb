class AddRoleToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :role, :integer, default: 1
  end
end
