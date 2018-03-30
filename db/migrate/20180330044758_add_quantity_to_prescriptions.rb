class AddQuantityToPrescriptions < ActiveRecord::Migration
  def change
    add_column :prescriptions, :quantity, :integer
  end
end
