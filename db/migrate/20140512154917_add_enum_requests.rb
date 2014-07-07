class AddEnumRequests < ActiveRecord::Migration
  def change
  		change_column :requests, :status, :integer, default: 1
  end
end
