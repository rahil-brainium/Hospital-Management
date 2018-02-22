class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :prescriptions, :type, :med_type
  end
end
