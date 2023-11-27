class AddClinicDogRefToMeetings < ActiveRecord::Migration[7.1]
  def change
    add_reference :meetings, :clinic_dog, null: true, foreign_key: true
  end
end
