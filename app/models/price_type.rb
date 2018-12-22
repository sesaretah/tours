class PriceType < ActiveRecord::Base
  self.primary_key = 'uuid'
  has_many :tours, :through => :pricings
  has_many :pricings, dependent: :destroy

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def find(uuid)
    PriceType.find_by_uuid(uuid)
  end
end
