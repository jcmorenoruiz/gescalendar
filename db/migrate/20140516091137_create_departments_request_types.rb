class CreateDepartmentsRequestTypes < ActiveRecord::Migration
  def change
    create_table :departments_request_types do |t|
      t.integer :num_max_dias
      t.references :request_type, index: true
      t.references :department, index: true

      t.timestamps
    end

   
  end
end
