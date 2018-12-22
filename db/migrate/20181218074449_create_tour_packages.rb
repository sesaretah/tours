class CreateTourPackages < ActiveRecord::Migration
  def change
    create_table :tour_packages do |t|
      t.string :title
      t.integer :days
      t.integer :nights
      t.text :details
      t.integer :agency_id
      t.string :uuid

      t.timestamps null: false
    end
  end
end
