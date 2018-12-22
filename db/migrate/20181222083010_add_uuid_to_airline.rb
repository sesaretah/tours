class AddUuidToAirline < ActiveRecord::Migration
  def change
    add_column :airlines, :uuid, :string
  end
end
