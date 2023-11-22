class AddTitleToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :title, :string
  end
end
