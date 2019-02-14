class Tour < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :airline
  belongs_to :tour_package

  has_many :accomodations, :dependent => :destroy
  has_many :hotels, :through => :accomodations

  has_many :transportations, :dependent => :destroy
  has_many :airlines, :through => :transportations
  has_many :railways, :through => :transportations

  has_many :price_types, :through => :pricings
  has_many :pricings, dependent: :destroy

  has_many :passengers, :through => :reservations
  has_many :reservations, dependent: :destroy


    def photos(style)
      @uploads = Upload.where(uploadable_id: self.id, attachment_type: 'tour_pictures')
      if !@uploads.blank?
        @images = []
        for upload in @uploads
          @images << {url: upload.attachment(style), id: upload.id}
        end
        return @images
      else
        return [{url: ActionController::Base.helpers.asset_path("noimage-#{style}.png", :digest => false), id: nil}]
      end
    end

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def remained_capacity
    @reservations_count = self.reservations.count
    if @reservations_count.blank?
      @reservations_count = 0
    end
    if !self.capacity.blank?
      @remainder = self.capacity - @reservations_count
    else
      @remainder = 0
    end
    if @remainder > -1
      return @remainder
    end
  end

  def id
    self.uuid
  end

  def jalali_start_date
    @jalali = JalaliDate.to_jalali(self.start_date)
    return "#{@jalali.year}/#{@jalali.month}/#{@jalali.day}"
  end

  def jalali_end_date
    @jalali = JalaliDate.to_jalali(self.end_date)
    return "#{@jalali.year}/#{@jalali.month}/#{@jalali.day}"
  end

  def self.find(uuid)
    Tour.find_by_uuid(uuid)
  end
end
