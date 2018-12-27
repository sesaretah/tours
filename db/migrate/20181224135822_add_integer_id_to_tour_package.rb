class AddIntegerIdToTourPackage < ActiveRecord::Migration
  def change
    add_column :tour_packages, :integer_id, :integer, auto_increment: true
    add_index :tour_packages, :integer_id, unique: true
  end
end
