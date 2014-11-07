class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :proxy_users, :password_digest, :string
  end
end
