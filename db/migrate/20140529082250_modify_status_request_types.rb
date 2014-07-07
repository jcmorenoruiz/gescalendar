class ModifyStatusRequestTypes < ActiveRecord::Migration
  def change
  		change_column :request_types, :status, :boolean, default: true
  end
end
