class ChangeSexAndBreedColumnFromDogs < ActiveRecord::Migration[7.1]
  def change
    remove_column :dogs, :sex, :string
    remove_column :dogs, :breed, :string
    add_column :dogs, :sex, :integer
    add_column :dogs, :breed, :integer
  end
end
