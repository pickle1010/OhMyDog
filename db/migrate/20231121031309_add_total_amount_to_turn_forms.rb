class AddTotalAmountToTurnForms < ActiveRecord::Migration[7.1]
  def change
    add_column :turn_forms, :total_amount, :decimal
  end
end
