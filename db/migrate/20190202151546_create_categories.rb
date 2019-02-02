class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :uuid
      t.string :title
      t.integer :user_id
      t.integer :integer_id
      t.integer :rank

      t.timestamps null: false
    end
    add_index :categories, :uuid, unique: true
  end
end
