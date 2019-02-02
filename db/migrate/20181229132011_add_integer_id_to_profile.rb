class AddIntegerIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :integer_id, :integer
    add_index :profiles, :integer_id
  end
end
