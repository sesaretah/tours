class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :title
      t.string :uuid

      t.timestamps null: false
    end
    add_index :roles, :uuid, unique: true
  end
end
