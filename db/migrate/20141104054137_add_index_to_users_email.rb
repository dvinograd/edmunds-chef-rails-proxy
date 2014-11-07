class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :proxy_users, :username, unique: true
    add_index :proxy_users, :email, unique: true
  end
end
