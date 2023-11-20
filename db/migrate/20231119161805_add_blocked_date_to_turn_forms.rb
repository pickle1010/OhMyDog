class AddBlockedDateToTurnForms < ActiveRecord::Migration[7.1]
  def change
    add_column :turn_forms, :block_date, :date
  end
end
