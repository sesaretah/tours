class AddProvinceIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :province_id, :string
    add_index :profiles, :province_id
  end
end
