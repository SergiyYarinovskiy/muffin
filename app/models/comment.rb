class Comment < ActiveRecord::Base
  belongs_to :hotel

  validates :body, presence: true
  validates :rating, presence: true
end
