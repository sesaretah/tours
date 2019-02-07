class AddNessFields < ActiveRecord::Migration
  def change
    add_column :tour_packages, :en_name_field, :boolean
    add_column :tour_packages, :en_surename_field, :boolean
    add_column :tour_packages, :en_father_name_field, :boolean
    add_column :tour_packages, :passport_no_field, :boolean

    add_column :tour_packages, :father_name_field, :boolean
    add_column :tour_packages, :birthdate_field, :boolean
    add_column :tour_packages, :place_of_birth_field, :boolean


    add_column :tour_packages, :attachment_field, :boolean
    add_column :tour_packages, :attachment_message, :text
  end
end
