class PriceType < ActiveRecord::Base
  has_many :tours, :through => :pricings
  has_many :pricings, dependent: :destroy
end
