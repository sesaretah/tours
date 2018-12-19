class CreateAccomodations < ActiveRecord::Migration
  def change
    create_table :accomodations do |t|
      t.string :accomodable_type
      t.integer :accomodable_id
      t.integer :tour_id

      t.timestamps null: false
    end
  end
end
