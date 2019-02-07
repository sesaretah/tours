class AddSomeFieldsToPassenger < ActiveRecord::Migration
  def change
    add_column :passengers, :en_name, :string
    add_column :passengers, :en_surename, :string
    add_column :passengers, :en_fathername, :string
  end
end
