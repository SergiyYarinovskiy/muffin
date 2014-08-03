class Hotel < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_one :address, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :address

  validates :title, presence: true
  validates :rating, presence: true
end
