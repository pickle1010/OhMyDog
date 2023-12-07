class ChangeDateToDatetimeFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :date, :date
    add_column :messages, :datetime, :datetime
  end
end
