class AddEmpRequestType < ActiveRecord::Migration
  def change
  		add_column :request_types, :tipo, :boolean, default: 't'
  end
end
