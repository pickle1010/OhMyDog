class AddVaccineFieldsToClinicDogs < ActiveRecord::Migration[7.1]
  def change
    add_column :clinic_dogs, :rabies_dosage, :decimal
    add_column :clinic_dogs, :rabies_batch, :string
    add_column :clinic_dogs, :inmunological_dosage, :decimal
    add_column :clinic_dogs, :inmunological_batch, :string
  end
end
