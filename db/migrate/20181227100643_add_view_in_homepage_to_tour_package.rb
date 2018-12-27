class AddViewInHomepageToTourPackage < ActiveRecord::Migration
  def change
    add_column :tour_packages, :view_in_homepage, :boolean
  end
end
