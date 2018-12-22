class AddUuidToTransportation < ActiveRecord::Migration
  def change
    add_column :transportations, :uuid, :string
  end
end
