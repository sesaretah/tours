class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.integer :stars
      t.string :city
      t.text :details

      t.timestamps null: false
    end
  end
end
