class CreateCreditCards < ActiveRecord::Migration[7.1]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.integer :expiration_month
      t.integer :expiration_year
      t.string :cvv
      t.string :name
      t.string :last_name
      t.integer :amount
      t.integer :type

      t.timestamps
    end
  end
end
