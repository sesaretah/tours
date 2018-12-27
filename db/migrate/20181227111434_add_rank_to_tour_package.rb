class AddRankToTourPackage < ActiveRecord::Migration
  def change
    add_column :tour_packages, :rank, :integer
  end
end
