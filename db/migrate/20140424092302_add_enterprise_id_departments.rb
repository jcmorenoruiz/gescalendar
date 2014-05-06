class AddEnterpriseIdDepartments < ActiveRecord::Migration
 
  def change
    create_table :departments do |t|
      t.string :nombre
      t.boolean :status , default: 't'
      t.integer :enterprise_id
      t.timestamps
    end
  end

end
