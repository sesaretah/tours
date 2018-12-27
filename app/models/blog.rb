class Blog < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :agency


  def cover(style)
    @upload = Upload.where(uploadable_id: self.id, attachment_type: 'blog_cover').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("#{rand(2..6)}.png", :digest => false)
    end
  end

  
  before_create :set_rank
  def set_uuid
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
    Blog.find_by_uuid(uuid)
  end
end
