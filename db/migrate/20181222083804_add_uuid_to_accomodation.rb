class AddUuidToAccomodation < ActiveRecord::Migration
  def change
    add_column :accomodations, :uuid, :string
  end
end
