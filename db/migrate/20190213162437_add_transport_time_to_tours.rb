class AddTransportTimeToTours < ActiveRecord::Migration
  def change
    add_column :tours, :transport_time, :time
  end
end
