class AddPositiveBalanceToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :positive_balance, :decimal, precision: 10, scale: 2, default: 0.0  
  end
end
