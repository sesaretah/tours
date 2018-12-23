class Tour < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :airline
  belongs_to :tour_packages

  has_many :accomodations, :dependent => :destroy
  has_many :hotels, :through => :accomodations

  has_many :transportations, :dependent => :destroy
  has_many :airlines, :through => :transportations
  has_many :railways, :through => :transportations

  has_many :price_types, :through => :pricings
  has_many :pricings, dependent: :destroy

  has_many :passengers, :through => :reservations
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
