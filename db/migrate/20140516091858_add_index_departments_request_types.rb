class AddIndexDepartmentsRequestTypes < ActiveRecord::Migration
  def change
  	 add_index :departments_request_types, [:department_id, :request_type_id], unique: true, name: 'departments_request_types_index'
  end
end
