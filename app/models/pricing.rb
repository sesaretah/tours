class Pricing < ActiveRecord::Base
  belongs_to :tour
  belongs_to :price_type
end
