class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :tour

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def find(uuid)
    Reservation.find_by_uuid(uuid)
  end
end
