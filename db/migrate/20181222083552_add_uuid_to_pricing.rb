class AddUuidToPricing < ActiveRecord::Migration
  def change
    add_column :pricings, :uuid, :string
  end
end
