class AddJefeAuditorToDepartments < ActiveRecord::Migration
  def change
     add_column :departments, :jefe_auditor, :boolean, default: true
  end
end
