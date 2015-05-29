class AddForeignKeysRequest < ActiveRecord::Migration
  def change
    add_foreign_key :requests, :employees
    add_foreign_key :requests, :request_types
  end
end
