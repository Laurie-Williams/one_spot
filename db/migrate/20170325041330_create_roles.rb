class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.references :user, foreign_key: true, index: true
      t.references :resource, polymorphic: true, index: true
      t.string :name, index: true
    end
  end
end
