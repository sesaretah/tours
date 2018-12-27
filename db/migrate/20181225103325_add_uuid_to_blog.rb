class AddUuidToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :uuid, :string
    add_index :blogs, :uuid, unique: true
  end
end
