class Pricing < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :tour
  belongs_to :price_type

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Pricing.find_by_uuid(uuid)
  end
end
