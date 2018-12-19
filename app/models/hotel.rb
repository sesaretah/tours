class Hotel < ActiveRecord::Base
  has_many :accomodations, :as => :accomodable, :dependent => :destroy
  has_many :tours, :through => :accomodations
end
