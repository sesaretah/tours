class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tours, :through => :reservations
  has_many :reservations, dependent: :destroy
end
