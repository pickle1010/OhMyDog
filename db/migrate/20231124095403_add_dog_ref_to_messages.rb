class AddDogRefToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :dog, null: true, foreign_key: true
  end
end
