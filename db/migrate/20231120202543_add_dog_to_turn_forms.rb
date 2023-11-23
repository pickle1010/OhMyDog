class AddDogToTurnForms < ActiveRecord::Migration[7.1]
  def change
    add_reference :turn_forms, :dog, null: false, foreign_key: true
  end
end
