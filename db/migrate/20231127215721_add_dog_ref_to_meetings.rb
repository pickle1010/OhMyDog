class AddDogRefToMeetings < ActiveRecord::Migration[7.1]
  def change
    add_reference :meetings, :dog, null: true, foreign_key: true
  end
end
