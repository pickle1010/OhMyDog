class AddConfirmedToTurnForms < ActiveRecord::Migration[7.1]
  def change
    add_column :turn_forms, :confirmed, :boolean, default: false  
  end
end
