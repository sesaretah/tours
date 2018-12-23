class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :surename
      t.string :business_id
      t.string :sex
      t.string :tel
      t.date :birthdate
      t.string :ssn
      t.string :place_of_birth
      t.string :passport_no
      t.integer :nation_id

      t.timestamps null: false
    end
    add_index :passengers, :business_id
  end
end
