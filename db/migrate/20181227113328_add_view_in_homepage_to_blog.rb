class AddViewInHomepageToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :view_in_homepage, :boolean
  end
end
