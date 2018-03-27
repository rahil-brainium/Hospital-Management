class AddOrganisationIdToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :organisation_id, :string
  end
end
