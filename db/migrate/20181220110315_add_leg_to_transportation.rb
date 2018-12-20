class AddLegToTransportation < ActiveRecord::Migration
  def change
    add_column :transportations, :leg, :string
  end
end
