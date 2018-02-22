class AddPatientIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :patient_id, :string
  end
end
