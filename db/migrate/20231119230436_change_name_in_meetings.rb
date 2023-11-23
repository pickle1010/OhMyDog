class ChangeNameInMeetings < ActiveRecord::Migration[7.1]
  def change
      remove_column :meetings, :name, :string
      add_column :meetings, :name, :integer
  end
end
