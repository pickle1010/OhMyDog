class AddCardTypeToCreditCards < ActiveRecord::Migration[7.1]
  def change
    add_column :credit_cards, :card_type, :string
  end
end
