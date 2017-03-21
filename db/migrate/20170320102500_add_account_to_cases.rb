class AddAccountToCases < ActiveRecord::Migration[5.0]
  def change
    add_column :cases, :account_id, :integer
    add_index :cases, :account_id
  end
end
