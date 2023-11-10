class AddServicesConsToTurnForms < ActiveRecord::Migration[7.1]
  def change
    add_column :turn_forms, :servicesCons, :string
  end
end
