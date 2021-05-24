class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :f_id
      t.timestamps
    end
  end
end
