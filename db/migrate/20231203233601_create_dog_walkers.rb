class CreateDogWalkers < ActiveRecord::Migration[7.1]
  def change
    create_table :dog_walkers do |t|
      t.string :name
      t.string :lastname
      t.string :workplace
      t.string :service
      t.string :contact

      t.timestamps
    end
  end
end
