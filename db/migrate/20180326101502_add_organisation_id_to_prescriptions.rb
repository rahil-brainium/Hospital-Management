class AddOrganisationIdToPrescriptions < ActiveRecord::Migration
  def change
    add_column :prescriptions, :organisation_id, :string
  end
end
