class AddCastratedToDogs < ActiveRecord::Migration[7.1]
  def change
    add_column :dogs, :castrated, :boolean
  end
end
