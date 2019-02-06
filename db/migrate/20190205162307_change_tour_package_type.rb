class ChangeTourPackageType < ActiveRecord::Migration
  def change
    change_column :tours, :tour_package_id, :string
  end
end
