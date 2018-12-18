class Agency < ActiveRecord::Base
  validates :name, presence: true
  validates_format_of :subdomain, :with =>  /\A[a-zA-Z0-9]*\z/

  belongs_to :user
  has_many :tour_packages

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def find(uuid)
    Agency.find_by_uuid(uuid)
  end
end
