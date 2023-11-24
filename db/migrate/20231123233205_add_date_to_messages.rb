class AddDateToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :date, :date
  end
end
