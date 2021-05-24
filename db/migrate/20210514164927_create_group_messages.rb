class CreateGroupMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :group_messages do |t|
      t.string :groupname
      t.integer :groupadmin_id
      t.boolean :bilateral, default: true
      t.timestamps
    end
  end
end
