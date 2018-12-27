class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.string :agency_id
      t.string :uuid

      t.timestamps null: false
    end
    add_index :blogs, :agency_id
    add_index :blogs, :uuid, unique: true
  end
end
