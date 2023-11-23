class AddVetDescriptionToTurnForms < ActiveRecord::Migration[7.1]
  def change
    add_column :turn_forms, :vet_description, :text
  end
end
