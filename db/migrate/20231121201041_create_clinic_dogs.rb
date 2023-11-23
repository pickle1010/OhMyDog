class CreateClinicDogs < ActiveRecord::Migration[7.1]
  def change
    create_table :clinic_dogs do |t|
      t.boolean :question
      t.date :dateclinic
      t.text :description

      t.timestamps
    end
  end
end
