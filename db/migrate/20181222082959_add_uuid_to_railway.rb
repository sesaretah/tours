class AddUuidToRailway < ActiveRecord::Migration
  def change
    add_column :railways, :uuid, :string
  end
end
