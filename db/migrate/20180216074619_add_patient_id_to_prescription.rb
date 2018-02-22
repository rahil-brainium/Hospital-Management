class AddPatientIdToPrescription < ActiveRecord::Migration
  def change
    add_column :prescriptions, :patient_id, :string
  end
end
