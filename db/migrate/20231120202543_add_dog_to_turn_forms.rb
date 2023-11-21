class AddDogToTurnForms < ActiveRecord::Migration[7.1]
  def change
    change_column :turn_forms, :dog_id, :integer, null: false
    add_foreign_key :turn_forms, :dogs
  end
end
