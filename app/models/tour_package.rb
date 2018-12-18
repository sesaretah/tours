class TourPackage < ActiveRecord::Base
  belongs_to :agency
  has_many :tours

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def find(uuid)
    TourPackage.find_by_uuid(uuid)
  end
end
