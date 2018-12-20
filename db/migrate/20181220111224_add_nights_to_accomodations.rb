class AddNightsToAccomodations < ActiveRecord::Migration
  def change
    add_column :accomodations, :nights, :integer
  end
end
