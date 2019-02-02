class AddStatusToTourPackage < ActiveRecord::Migration
  def change
    add_column :tour_packages, :status, :integer
  end
end
