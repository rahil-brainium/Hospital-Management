class AddDiseaseTypeToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :disease_type, :string
  end
end
