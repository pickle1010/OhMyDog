class CreateMeetings < ActiveRecord::Migration[7.1]
  def change
    create_table :meetings do |t|
      t.string :name
      t.date :start_time

      t.timestamps
    end
  end
end
