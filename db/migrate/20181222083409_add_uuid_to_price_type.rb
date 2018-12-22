class AddUuidToPriceType < ActiveRecord::Migration
  def change
    add_column :price_types, :uuid, :string
  end
end
