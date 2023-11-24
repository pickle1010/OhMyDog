class AddDescriptionId < ActiveRecord::Migration[7.1]
  def change
    add_column :meetings, :description, :string
    add_reference :meetings, :user, null: true, foreign_key: true
  end
end
