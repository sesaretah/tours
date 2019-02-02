class Category < ActiveRecord::Base
  self.primary_key = 'uuid'
  belongs_to :user
  has_many :tour_packages

  before_create :set_integer_id

  def cover(style)
    @upload = Upload.where(uploadable_id: self.id, attachment_type: 'category_cover').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("#{rand(2..6)}.png", :digest => false)
    end
  end

  before_create :set_rank
  def set_rank
    self.rank = 0
  end

  def set_integer_id
    @last = Category.all.order('integer_id desc').first
    if !@last.blank?
      @last_id = @last.integer_id
    else
      @last_id = 0
    end
    self.integer_id = @last_id + 1
  end

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def id
    self.uuid
  end

  def self.find(uuid)
    Category.find_by_uuid(uuid)
  end
end
