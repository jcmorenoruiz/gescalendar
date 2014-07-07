class RenameDepartmentIdColumnRequestTypes < ActiveRecord::Migration
  def change
  	rename_column :request_types,:department_id,:enterprise_id
  end
end

