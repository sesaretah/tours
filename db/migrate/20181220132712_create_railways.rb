class CreateRailways < ActiveRecord::Migration
  def change
    create_table :railways do |t|
      t.string :name
      t.string :wagon_type
      t.integer :number_of_seats
      t.integer :agency_id

      t.timestamps null: false
    end
  end
end
