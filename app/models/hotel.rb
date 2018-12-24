class Hotel < ActiveRecord::Base
  self.primary_key = 'uuid'
  has_many :accomodations, :as => :accomodable, :dependent => :destroy
  has_many :tours, :through => :accomodations

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Hotel.find_by_uuid(uuid)
  end

  def star
    @result = ''
    if self.stars.blank?
      self.stars = 0
    end
    for i in (1..self.stars)
      @result = @result + "<i class='fa fa-star'></i>"
    end
    for j in ((self.stars+1)..5)
      @result = @result + "<i class='fa fa-star-o'></i>"
    end
    return @result
  end
end
