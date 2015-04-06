class AddCountryToEnterprises < ActiveRecord::Migration
  def change
  	add_column :enterprises, :country, :string
  end
end
