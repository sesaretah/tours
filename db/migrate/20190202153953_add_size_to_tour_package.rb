class AddSizeToTourPackage < ActiveRecord::Migration
  def change
    add_column :tour_packages, :size, :integer
  end
end
