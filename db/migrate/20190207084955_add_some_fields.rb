class AddSomeFields < ActiveRecord::Migration
  def change
    add_column :profiles, :en_name, :string
    add_column :profiles, :en_surename, :string
    add_column :profiles, :en_fathername, :string
  end
end
