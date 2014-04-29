class AddEnterpriseIdDepartments < ActiveRecord::Migration
 
  def change
    create_table :departments do |t|
      t.string :nombre
      t.boolean :status
     
      t.timestamps
    end
  end

end
