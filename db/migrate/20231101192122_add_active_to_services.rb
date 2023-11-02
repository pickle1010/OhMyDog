class AddActiveToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :active, :boolean
  end
end
