class CreateTransportations < ActiveRecord::Migration
  def change
    create_table :transportations do |t|
      t.string :transportable_type
      t.integer :transportable_id
      t.integer :tour_id

      t.timestamps null: false
    end
  end
end
