class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :phone_number
      t.string :uuid
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :profiles, :uuid, unique: true
  end
end
