class Transportation < ActiveRecord::Base
  belongs_to :transportable, :polymorphic => true
  belongs_to :airline, :class_name => "Airline", :foreign_key => "transportable_id"
  belongs_to :railway, :class_name => "Railway", :foreign_key => "transportable_id"
  belongs_to :tour
end
