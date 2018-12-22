class AddUuidToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :uuid, :string
  end
end
