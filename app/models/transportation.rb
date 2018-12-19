class Transportation < ActiveRecord::Base
  belongs_to :transportable, :polymorphic => true
  belongs_to :airline, :class_name => "Airline", :foreign_key => "transportable_id"
  belongs_to :tour
end
