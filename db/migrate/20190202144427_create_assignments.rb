class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :role_id
      t.integer :user_id
      t.string :uuid

      t.timestamps null: false
    end
    add_index :assignments, :role_id
    add_index :assignments, :uuid, unique: true
  end
end
