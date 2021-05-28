class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :user_id
      t.string :view
      t.timestamps
    end
    add_foreign_key :posts, :users, column: :user_id, on_delete: :cascade
  end
end
