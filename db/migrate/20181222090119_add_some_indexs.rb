class AddSomeIndexs < ActiveRecord::Migration

    add_index :accomodations, :tour_id
    add_index :accomodations, :accomodable_id
    add_index :accomodations, :uuid, unique: true
    add_index :pricings, :tour_id
    add_index :pricings, :price_type_id
    add_index :pricings, :agency_id
    add_index :pricings, :uuid, unique: true
    add_index :reservations, :tour_id
    add_index :tour_packages, :agency_id
    add_index :tour_packages, :uuid
    add_index :transportations, :tour_id
    add_index :transportations, :transportable_id
    add_index :transportations, :uuid, unique: true
    add_index :airlines, :uuid, unique: true
    add_index :railways, :uuid, unique: true
    add_index :hotels, :uuid, unique: true
    add_index :tours, :uuid, unique: true
    add_index :agencies, :uuid, unique: true

end
