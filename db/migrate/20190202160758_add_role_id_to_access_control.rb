class AddRoleIdToAccessControl < ActiveRecord::Migration
  def change
    add_column :access_controls, :role_id, :string
    add_index :access_controls, :role_id
  end
end
