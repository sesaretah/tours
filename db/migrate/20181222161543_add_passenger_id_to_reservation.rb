class AddPassengerIdToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :passenger_id, :string
    add_index :reservations, :passenger_id
  end
end
