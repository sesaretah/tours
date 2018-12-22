class ChangeIdColumns < ActiveRecord::Migration
  def change
    change_column :accomodations, :tour_id, :string
    change_column :accomodations, :accomodable_id, :string
    change_column :pricings, :tour_id, :string
    change_column :pricings, :price_type_id, :string
    change_column :pricings, :agency_id, :string
    change_column :reservations, :tour_id, :string
    change_column :tour_packages, :agency_id, :string
    change_column :transportations, :tour_id, :string
    change_column :transportations, :transportable_id, :string
    change_column :uploads, :uploadable_id, :string
  end
end
