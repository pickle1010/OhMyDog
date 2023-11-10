class CreateTurnForms < ActiveRecord::Migration[7.1]
  def change
    create_table :turn_forms do |t|
      t.string :DateCons
      t.string :ScheduleCons
      t.string :descriptionCons

      t.timestamps
    end
  end
end
