class Passenger < ActiveRecord::Base
  self.primary_key = 'uuid'

  has_many :passengers, :through => :reservations
  has_many :reservations, dependent: :destroy
  has_many :uploads, :as => :uploadable, :dependent => :destroy

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Passenger.find_by_uuid(uuid)
  end
end
