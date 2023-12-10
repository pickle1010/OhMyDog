class CreateWantedPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :wanted_posts do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
