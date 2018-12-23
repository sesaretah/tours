class AddUuidToPassenger < ActiveRecord::Migration
  def change
    add_column :passengers, :uuid, :string
    add_index :passengers, :uuid, unique: true
  end
end
