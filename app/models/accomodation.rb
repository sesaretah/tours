class Accomodation < ActiveRecord::Base
  belongs_to :tour
  belongs_to :accomodable, :polymorphic => true
  belongs_to :hotel, :class_name => "Hotel", :foreign_key => "accomodable_id"
end
