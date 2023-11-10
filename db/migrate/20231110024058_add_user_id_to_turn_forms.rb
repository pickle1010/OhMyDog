class AddUserIdToTurnForms < ActiveRecord::Migration[7.1]
  def change
    add_reference :turn_forms, :user, null: false, foreign_key: true
  end
end
