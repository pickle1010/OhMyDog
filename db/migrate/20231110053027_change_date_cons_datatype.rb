class ChangeDateConsDatatype < ActiveRecord::Migration[7.1]
  def change 
    remove_column :turn_forms, :DateCons, :string
    add_column :turn_forms, :dateCons, :date
  end
end
