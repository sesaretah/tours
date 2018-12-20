class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.integer :tour_id
      t.integer :price_type_id
      t.integer :value
      t.integer :agency_id

      t.timestamps null: false
    end
  end
end
