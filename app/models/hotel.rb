class Hotel < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_one :address, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :address

  has_attached_file :hotel_image, styles: { thumb: "100x100>" },
    default_url: 'miss.jpg'

  validates :title, presence: true
  validates :rating, presence: true
  validates_attachment_content_type :hotel_image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :hotel_image, less_than: 10.megabytes
end
