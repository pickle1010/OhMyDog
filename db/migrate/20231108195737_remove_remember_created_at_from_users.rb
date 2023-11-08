class RemoveRememberCreatedAtFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :remember_created_at, :datetime
  end
end
