class AddTransportTimeToTransportation < ActiveRecord::Migration
  def change
    add_column :transportations, :transport_time, :time
  end
end
