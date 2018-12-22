class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.date :start_date
      t.date :end_date
      t.integer :price
      t.text :details
      t.integer :tour_package_id
      t.string :uuid

      t.timestamps null: false
    end

  end
end
