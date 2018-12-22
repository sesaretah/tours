class Railway < ActiveRecord::Base
  has_many :transportations, :as => :transportable, :dependent => :destroy
  has_many :tours, :through => :transportations
end
