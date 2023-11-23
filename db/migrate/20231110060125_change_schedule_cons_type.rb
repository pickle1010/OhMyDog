class ChangeScheduleConsType < ActiveRecord::Migration[7.1]
  def change
    remove_column :turn_forms, :ScheduleCons, :string
    add_column :turn_forms, :scheduleCons, :integer
  end
end
