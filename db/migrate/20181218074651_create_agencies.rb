class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :tel
      t.string :telegram_channel
      t.string :instagram_page
      t.text :address
      t.string :uuid
      t.integer :user_id
      t.string :subdomain
      t.string :mobile
      t.string :fax
      t.string :email
      t.text :about_us

      t.timestamps null: false
    end
  end
end
