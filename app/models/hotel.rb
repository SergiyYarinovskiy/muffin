class Hotel < ActiveRecord::Base
  has_many :comments
  has_one :address
  belongs_to :user

  validates :title, presence: true
  validates :rating, presence: true
end
