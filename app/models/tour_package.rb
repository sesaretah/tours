class TourPackage < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :agency
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
