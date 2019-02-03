class TourPackage < ActiveRecord::Base
  self.primary_key = 'uuid'
  after_save ThinkingSphinx::RealTime.callback_for(:tour_package)

  belongs_to :agency
  belongs_to :province

  has_many :tours, :dependent => :destroy
  has_many :uploads, :as => :uploadable, :dependent => :destroy

  def image(style)
    @upload = Upload.where(uploadable_type: 'TourPackage', uploadable_id: self.id, attachment_type: 'tour_package_attachment').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-35-#{style}.jpg", :digest => false)
    end
  end

  def cover(style)
    @upload = Upload.where(uploadable_id: self.id, attachment_type: 'tour_package_attachment').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-#{style}.png", :digest => false)
    end
  end

  before_create :set_integer_id
  def set_integer_id
    @last = TourPackage.all.order('integer_id desc').first
    if !@last.blank?
      @last_id = @last.integer_id
    else
      @last_id = 0
    end
    self.integer_id = @last_id + 1
  end

  before_create :set_rank
  def set_rank
    self.rank = 0
  end

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    TourPackage.find_by_uuid(uuid)
  end

end
