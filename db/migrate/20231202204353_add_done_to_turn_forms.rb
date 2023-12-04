class AddDoneToTurnForms < ActiveRecord::Migration[7.1]
  def change
    add_column :turn_forms, :done, :boolean, default: false
  end
end
