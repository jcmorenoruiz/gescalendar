class AddColorAvailabilities < ActiveRecord::Migration
  def change
  	add_column :request_types, :color, :string
  end
end
