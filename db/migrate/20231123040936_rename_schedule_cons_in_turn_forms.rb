class RenameScheduleConsInTurnForms < ActiveRecord::Migration[7.1]
  def change
    rename_column :turn_forms, :scheduleCons, :schedule
  end
end
