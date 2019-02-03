class CreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.string :name
      t.integer :capacity
      t.integer :agency_id
      t.string :uuid

      t.timestamps null: false
    end
    add_index :buses, :uuid, unique: true
  end
end
