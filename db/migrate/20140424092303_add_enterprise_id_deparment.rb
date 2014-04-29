class AddEnterpriseIdDeparment < ActiveRecord::Migration
  def change
  		add_column :departments, :enterprise_id , :integer
  end
end
