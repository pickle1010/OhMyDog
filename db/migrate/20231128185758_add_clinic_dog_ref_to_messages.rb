class AddClinicDogRefToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :clinic_dog, null: true, foreign_key: true
  end
end
