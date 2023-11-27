class AddTurnFormRefToMeetings < ActiveRecord::Migration[7.1]
  def change
    add_reference :meetings, :turn_form, null: true, foreign_key: true
  end
end
