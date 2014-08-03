class Address < ActiveRecord::Base
  belongs_to :hotel

  validates :country, presence: true
end
