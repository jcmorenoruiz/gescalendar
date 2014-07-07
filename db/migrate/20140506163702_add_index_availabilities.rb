class AddIndexAvailabilities < ActiveRecord::Migration
  def change
  	change_column :availabilities, :status , :boolean, default: 't'
  end
end
