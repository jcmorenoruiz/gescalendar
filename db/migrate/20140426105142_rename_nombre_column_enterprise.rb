class RenameNombreColumnEnterprise < ActiveRecord::Migration
  def change
  	rename_column :enterprises, :nombre , :empresa
  end
end
