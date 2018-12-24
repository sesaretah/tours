class Accomodation < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :tour
  belongs_to :accomodable, :polymorphic => true
  belongs_to :hotel, :class_name => "Hotel", :foreign_key => "accomodable_id"

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Accomodation.find_by_uuid(uuid)
  end
end
