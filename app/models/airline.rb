class Airline < ActiveRecord::Base
  self.primary_key = 'uuid'
  has_many :transportations, :as => :transportable, :dependent => :destroy
  has_many :tours, :through => :transportations

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def find(uuid)
    Airline.find_by_uuid(uuid)
  end
end
