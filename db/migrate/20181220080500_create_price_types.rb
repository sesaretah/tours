class CreatePriceTypes < ActiveRecord::Migration
  def change
    create_table :price_types do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
