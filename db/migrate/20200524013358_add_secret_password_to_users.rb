class AddSecretPasswordToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :secret_password, :string
  end
end
