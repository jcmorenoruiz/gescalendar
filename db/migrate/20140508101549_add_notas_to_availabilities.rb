class AddNotasToAvailabilities < ActiveRecord::Migration
  def change
  	add_column :availabilities, :notas, :text
  end
end
