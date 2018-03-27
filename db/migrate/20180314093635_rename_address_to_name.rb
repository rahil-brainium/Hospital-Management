class RenameAddressToName < ActiveRecord::Migration
  def change
  	rename_column :addresses, :address, :name
  end
end
