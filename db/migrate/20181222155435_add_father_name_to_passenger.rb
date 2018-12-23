class AddFatherNameToPassenger < ActiveRecord::Migration
  def change
    add_column :passengers, :father_name, :string
  end
end
