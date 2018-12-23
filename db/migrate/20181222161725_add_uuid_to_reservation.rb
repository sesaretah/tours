class AddUuidToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :uuid, :string
    add_index :reservations, :uuid, unique: true
  end
end
