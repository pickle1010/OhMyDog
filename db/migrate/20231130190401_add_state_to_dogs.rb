class AddStateToDogs < ActiveRecord::Migration[7.1]
  def change
    add_column :dogs, :state, :boolean, default: true
  end
end
