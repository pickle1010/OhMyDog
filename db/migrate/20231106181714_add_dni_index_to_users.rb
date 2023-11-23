class AddDniIndexToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :dni, unique: true
  end
end
