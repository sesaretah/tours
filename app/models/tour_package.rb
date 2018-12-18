class TourPackage < ActiveRecord::Base
  belongs_to :agency
  has_many :tours

  def image(style)
    @upload = Upload.where(uploadable_type: 'TourPackage', uploadable_id: self.uuid, attachment_type: 'tour_package_attachment').first
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