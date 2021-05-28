class AddForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :friends, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :friends, :users, column: :f_id, on_delete: :cascade
    add_foreign_key :messages, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :messages, :group_messages, column: :group_message_id, on_delete: :cascade
    add_foreign_key :group_messages, :users, column: :groupadmin_id, on_delete: :nullify
    add_column :messages, :initiate, :boolean, default: false
  end
end
