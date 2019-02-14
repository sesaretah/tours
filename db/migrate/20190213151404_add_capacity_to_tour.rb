class AddCapacityToTour < ActiveRecord::Migration
  def change
    add_column :tours, :capacity, :integer
  end
end
