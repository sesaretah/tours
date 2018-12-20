class Tour < ActiveRecord::Base
  belongs_to :airline
  belongs_to :hotel
  belongs_to :tour_packages

  has_many :price_types, :through => :pricings
  has_many :pricings, dependent: :destroy

  has_many :users, as: :passengers, :through => :reservations
  has_many :reservations, dependent: :destroy

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Tour.find_by_uuid(uuid)
  end
end
