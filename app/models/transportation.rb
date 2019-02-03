class Transportation < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :transportable, :polymorphic => true
  belongs_to :airline, :class_name => "Airline", :foreign_key => "transportable_id"
  belongs_to :railway, :class_name => "Railway", :foreign_key => "transportable_id"
  belongs_to :bus, :class_name => "Bus", :foreign_key => "transportable_id"
  belongs_to :tour

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Transportation.find_by_uuid(uuid)
  end
end
