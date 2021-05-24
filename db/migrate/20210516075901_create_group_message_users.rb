class CreateGroupMessageUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_message_users do |t|
      t.integer :user_id
      t.integer :group_message_id
      t.timestamps
    end
  end
end
