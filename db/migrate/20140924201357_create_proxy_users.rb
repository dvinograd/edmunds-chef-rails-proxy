class CreateProxyUsers < ActiveRecord::Migration
  def change
    create_table :proxy_users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :pubkey

      t.timestamps null: false
    end
  end
end
