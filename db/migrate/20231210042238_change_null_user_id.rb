class ChangeNullUserId < ActiveRecord::Migration[7.1]
  def change
    change_column_null :credit_cards, :user_id, true
  end
end
