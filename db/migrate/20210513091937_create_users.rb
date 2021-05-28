class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, :email
      t.string :password_digest
      t.text :about, default: "Newly joined"
      t.timestamps
    end
    add_index :users, [:username, :email], unique: true
  end
end
