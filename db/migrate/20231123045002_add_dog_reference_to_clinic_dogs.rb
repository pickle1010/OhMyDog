class AddDogReferenceToClinicDogs < ActiveRecord::Migration[7.1]
  def change
    add_reference :clinic_dogs, :dog, null: false, foreign_key: true
  end
end
