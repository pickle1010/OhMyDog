class CreateCreditCards < ActiveRecord::Migration[7.1]
  def change
    create_table :credit_cards do |t|
      t.string :card_type
      t.string :card_number
      t.string :name
      t.string :last_name
      t.string :expiration_date
      t.decimal :amount

      t.timestamps
    end
  end
end
