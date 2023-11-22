class CreateDogs < ActiveRecord::Migration[7.1]
  def change
    create_table :dogs do |t|
      t.string :first_name
      t.string :last_name
      t.string :breed
      t.string :color
      t.string :sex
      t.date :birthday
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
