class RenameColumnDepartmentIdRequestType < ActiveRecord::Migration
  def change
  	rename_column :request_types, :calendar_id , :department_id
  end
end
