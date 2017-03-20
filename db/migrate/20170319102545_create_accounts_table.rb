class CreateAccountsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :subdomain

      t.index :subdomain
    end
  end
end
